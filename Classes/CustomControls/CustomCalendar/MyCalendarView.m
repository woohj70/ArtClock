//
//  MyCalendarView.m
//  MyCalendarTest
//
//  Created by HYOUNG JUN WOO on 10. 4. 18..
//  Copyright 2010 Mazdah.com. All rights reserved.
//

#import "MyCalendarView.h"
#import "KLCalendarModel.h"
//#import "KLColors.h"
//#import "KLGraphicsUtils.h"
#import "THCalendarInfo.h"


@interface MyCalendarView ()
- (void)addUI;
- (void)refreshViewWithPushDirection:(NSString *)caTransitionSubtype;
- (void)showPreviousMonth;
- (void)showFollowingMonth;
@end

@implementation MyCalendarView

@synthesize delegate;
@synthesize dateButtons;
@synthesize dates;
@synthesize calendarContainer;
@synthesize headerView;
@synthesize dayNameView;

@synthesize shootingDatas;
@synthesize anniversaryDatas;
@synthesize dateFormatter;
@synthesize bgView;
//@synthesize container;

/*
 - (id)initWithImage:(UIImage *)image  delegate:(id <MyCalendarViewDelegate>)aDelegate{
 if (self = [super initWithImage:image]) {
 // Initialization code
 self.delegate = aDelegate;
 self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
 self.autoresizesSubviews = YES;
 self.userInteractionEnabled = YES;
 self.frame = CGRectMake(0.0f, 44.0f, 320.0f, 416.0f);
 
 calendarModel = [[KLCalendarModel alloc] init];
 self.calendarContainer = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 54.0f, 320.0f, 323.0f)] autorelease];		
 self.dates = [[NSMutableArray alloc] init];
 self.dateButtons = [[NSMutableArray alloc]	init];
 
 [self addUI];
 [self refreshViewWithPushDirection:nil];
 }
 return self;
 }
 */


- (id)initWithFrame:(CGRect)frame  delegate:(id <MyCalendarViewDelegate>)aDelegate withManagedObjectContext:managedObjectContext{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.delegate = aDelegate;
		//		self.backgroundColor = [UIColor blackColor];
		//		self.image = [UIImage imageNamed:@"background.png"];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.autoresizesSubviews = YES;
		self.userInteractionEnabled = YES;
		self.frame = frame;//CGRectMake(10.0f, 80.0f, 300.0f, 300.0f);
        self.backgroundColor = [UIColor clearColor];

        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
        bgView.image = [UIImage imageNamed:@"calendarbg.png"];
		
        [self addSubview:bgView];
        
		calendarModel = [[KLCalendarModel alloc] init];
        
        ldButtonHeight = (self.bounds.size.height - (self.bounds.size.height * 15 / 100)) / 7;
        ldButtonWidth = (self.bounds.size.width - 10) / 7;
        fontSize = (ldButtonWidth / 2) - (ldButtonWidth * 10 / 100);
        
		self.calendarContainer = [[[UIView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.bounds.size.width - 10, self.bounds.size.height - 10)] autorelease];	
        self.calendarContainer.backgroundColor = [UIColor clearColor];
		self.dates = [[NSMutableArray alloc] init];
		self.dateButtons = [[NSMutableArray alloc]	init];
		
/*		
		NSError *error = nil;
		if (![[self fetchedResultsController] performFetch:&error]) {

			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
*/		
		[self addUI];
		[self refreshViewWithPushDirection:nil];
//		[self setNeedsDisplay];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //	[self drawGradientHeaderInContext:ctx];
        [self drawDayNamesInContext:ctx];
    }
    return self;
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)moveCalendar:(CGRect)frame {
    self.frame = frame;
}

- (void)resizeCalendar:(CGRect)frame {
    self.frame = frame;
//    self.bounds = frame;
    
    ldButtonHeight = (self.bounds.size.height - (self.bounds.size.height * 15 / 100)) / 7;
    ldButtonWidth = (self.bounds.size.width - 10) / 7;
    fontSize = (ldButtonWidth / 2) - (ldButtonWidth * 10 / 100);
    
    [bgView removeFromSuperview];
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
    bgView.image = [UIImage imageNamed:@"calendarbg.png"];
    
    [self addSubview:bgView];
    
    [self.calendarContainer removeFromSuperview];
    self.calendarContainer = [[[UIView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.bounds.size.width - 10, self.bounds.size.height - 10)] autorelease];
    
    [headerView removeFromSuperview];
    [dayNameView removeFromSuperview];
    
    [self addUI];
    [self removeAllButtons];
    [self refreshViewWithPushDirection:nil];
//    [self drawCalendarBody];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	//	[self drawGradientHeaderInContext:ctx];
    [self drawDayNamesInContext:ctx];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == alertView.cancelButtonIndex) {
		//		[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	}
}

#pragma mark -
#pragma mark Draw Calendar

- (void)drawCalendarHead {
}


- (void)selectedDateButton:(CalendarButton *)dateButton {
	//	dateButton.selected = !dateButton.selected;
	[delegate popupView:dateButton];
}

- (CGFloat)headerHeight { return 0.13707f * self.bounds.size.height; }

- (void)drawDayNamesInContext:(CGContextRef)ctx
{
	CGFloat columnWidth = ldButtonWidth;
	CGFloat fontSize = 0.3f * columnWidth;
    
    dayNameView = [[UIView alloc] initWithFrame:CGRectMake(5, ldButtonHeight + 2 + HEADER_Y, columnWidth * 7, fontSize)];
    dayNameView.backgroundColor = [UIColor lightGrayColor];
    for (NSInteger columnIndex = 0; columnIndex < 7; columnIndex++) {
		UILabel *weekDayName = nil;
        NSString *header; 
		
		weekDayName = [[UILabel alloc] initWithFrame:CGRectMake(columnIndex * columnWidth, 0, columnWidth, fontSize)];
		if ([[[NSLocale currentLocale] identifier] isEqualToString:@"ko_KR"]) {			
			header = [calendarModel dayNameAbbreviationForDayOfWeek:columnIndex];
		} else {
//			weekDayName = [[UILabel alloc] initWithFrame:CGRectMake(columnIndex * columnWidth + 14, [self headerHeight] - fontSize + 25, columnWidth, fontSize)];
			header = [calendarModel dayNameEAbbreviationForDayOfWeek:columnIndex];
		}
		
		weekDayName.backgroundColor = [UIColor clearColor];
        if (columnIndex == 0) { 
			weekDayName.textColor = [UIColor redColor];
		} else if (columnIndex == 6) {
			weekDayName.textColor = [UIColor blueColor];
		} else {
			weekDayName.textColor = [UIColor whiteColor];		
		}
		
		weekDayName.font = [UIFont systemFontOfSize:fontSize];
		weekDayName.text = header;
		weekDayName.textAlignment = UITextAlignmentCenter;
//		weekDayName.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
		[dayNameView addSubview:weekDayName];
		[weekDayName release];
    }
    
    [self addSubview:dayNameView];
}

// --------------------------------------------------------------------------------------------
//      drawGradientHeaderInContext:
// 
//      Draw the subtle gray vertical gradient behind the month, year, arrows, and day names
//
/*
 - (void)drawGradientHeaderInContext:(CGContextRef)ctx
 {
 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
 
 CGColorRef rawColors[2] = { kCalendarHeaderLightColor, kCalendarHeaderDarkColor };
 CFArrayRef colors = CFArrayCreate(NULL, (void*)&rawColors, 2, NULL);
 
 CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, NULL);
 CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0,0), CGPointMake(0, [self headerHeight]), kCGGradientDrawsBeforeStartLocation);
 
 CGGradientRelease(gradient);
 CFRelease(colors);
 CGColorSpaceRelease(colorSpace);    
 }
 */

// --------------------------------------------------------------------------------------------
//      addUI:
// 
//      Create the calendar header buttons and labels and add them to the calendar view.
//      This setup is only performed once during the life of the calendar.
//

- (void)addUI
{			
	//	CGContextRef ctx = UIGraphicsGetCurrentContext();
	//	[self drawGradientHeaderInContext:ctx];
	//   [self drawDayNamesInContext:ctx];
	
	//	[self setNeedsDisplay];
	
	// Create the previous month button on the left side of the view
    headerView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x,
                                                          self.bounds.origin.y + HEADER_Y,
                                                          self.bounds.size.width, 
                                                          ldButtonHeight + 2)];
    /*
    CGRect previousYearButtonFrame = CGRectMake(self.headerView.bounds.origin.x,
												self.headerView.bounds.origin.y,
												ldButtonWidth, 
												ldButtonHeight + 2);
    UIButton *previousYearButton = [[UIButton alloc] initWithFrame:previousYearButtonFrame];
    [previousYearButton setImage:[UIImage imageNamed:@"left-duparrow.png"] forState:UIControlStateNormal];
    previousYearButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    previousYearButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [previousYearButton addTarget:self action:@selector(showPreviousYear) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:previousYearButton];
    [previousYearButton release];
	*/
	
    // Create the previous month button on the left side of the view
    CGRect previousMonthButtonFrame = CGRectMake(self.headerView.bounds.origin.x,// + KL_CHANGE_MONTH_BUTTON_WIDTH,
                                                 self.headerView.bounds.origin.y,
                                                 ldButtonWidth, 
                                                 ldButtonHeight + 2);
    UIButton *previousMonthButton = [[UIButton alloc] initWithFrame:previousMonthButtonFrame];
    [previousMonthButton setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    previousMonthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    previousMonthButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [previousMonthButton addTarget:self action:@selector(showPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:previousMonthButton];
    [previousMonthButton release];
    
    // Draw the selected month name centered and at the top of the view	
    float fontSize = (ldButtonHeight + 4 / 2) - (ldButtonWidth * 10 / 100);
    CGRect selectedMonthLabelFrame = CGRectMake((self.bounds.size.width/2.0f) - (KL_SELECTED_MONTH_WIDTH/2.0f),
                                                self.headerView.bounds.origin.y, 
                                                KL_SELECTED_MONTH_WIDTH, 
                                                ldButtonHeight + 2);
    _selectedMonthLabel = [[UILabel alloc] initWithFrame:selectedMonthLabelFrame];
    _selectedMonthLabel.textColor = [UIColor whiteColor];
    _selectedMonthLabel.backgroundColor = [UIColor clearColor];
    _selectedMonthLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    _selectedMonthLabel.textAlignment = UITextAlignmentCenter;
    [self.headerView addSubview:_selectedMonthLabel];
    
	// Create the next month button on the right side of the view
    NSLog([NSString stringWithFormat:@"ldButtonWidth = %f", ldButtonWidth]);
    NSLog([NSString stringWithFormat:@"ldButtonWidth = %f", self.bounds.size.width]);
    CGRect nextMonthButtonFrame = CGRectMake(self.headerView.frame.size.width - ldButtonWidth, // - KL_CHANGE_MONTH_BUTTON_WIDTH * 2, 
                                             self.headerView.bounds.origin.y, 
                                             ldButtonWidth, 
                                             ldButtonHeight + 2);
    UIButton *nextMonthButton = [[UIButton alloc] initWithFrame:nextMonthButtonFrame];
    [nextMonthButton setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
    nextMonthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    nextMonthButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [nextMonthButton addTarget:self action:@selector(showFollowingMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:nextMonthButton];
    [nextMonthButton release];
	
	
    // Create the next month button on the right side of the view
    /*
    CGRect nextYearButtonFrame = CGRectMake(self.headerView.bounds.size.width - KL_CHANGE_MONTH_BUTTON_WIDTH, 
											self.headerView.bounds.origin.y, 
											ldButtonWidth, 
											ldButtonHeight + 2);
    UIButton *nextYearButton = [[UIButton alloc] initWithFrame:nextYearButtonFrame];
    [nextYearButton setImage:[UIImage imageNamed:@"right-duparrow.png"] forState:UIControlStateNormal];
    nextYearButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    nextYearButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [nextYearButton addTarget:self action:@selector(showFollowingYear) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:nextYearButton];
    [nextYearButton release];
	*/
	[self addSubview:self.calendarContainer];
    [self addSubview:self.headerView];
    [self bringSubviewToFront:headerView];
     
	//	[calendarContainer release];
}

// --------------------------------------------------------------------------------------------
//      showPreviousMonth
// 
//      Triggered whenever the previous button is tapped or when a date in
//      the previous month is tapped. Selects the previous month and updates the view.
//      Note that it is disabled while the calendar is in editing mode.
//
- (void)showPreviousMonth
{   
    [calendarModel decrementMonth];
	[self refreshViewWithPushDirection:kCATransitionFromLeft];
}

// --------------------------------------------------------------------------------------------
//      showFollowingMonth
// 
//      Triggered whenever the 'next' button is tapped or when a date in
//      the following month is tapped. Selects the next month and updates the view.
//      Note that it is disabled while the calendar is in editing mode.
//

- (void)showFollowingMonth
{	
    [calendarModel incrementMonth];
	[self refreshViewWithPushDirection:kCATransitionFromRight];
	//	[self setNeedsDisplay];
}

// --------------------------------------------------------------------------------------------
//      showPreviousMonth
// 
//      Triggered whenever the previous button is tapped or when a date in
//      the previous month is tapped. Selects the previous month and updates the view.
//      Note that it is disabled while the calendar is in editing mode.
//
- (void)showPreviousYear
{   
    [calendarModel decrementYear];
	[self refreshViewWithPushDirection:kCATransitionFromTop];
	//	[self setNeedsDisplay];
}

// --------------------------------------------------------------------------------------------
//      showFollowingMonth
// 
//      Triggered whenever the 'next' button is tapped or when a date in
//      the following month is tapped. Selects the next month and updates the view.
//      Note that it is disabled while the calendar is in editing mode.
//

- (void)showFollowingYear
{	
    [calendarModel incrementYear];
	[self refreshViewWithPushDirection:kCATransitionFromBottom];
	//	[self setNeedsDisplay];
}


// --------------------------------------------------------------------------------------------
//      refreshViewWithPushDirection:
// 
//      Triggered when the calendar is first created and whenever the selected month changes.
//
- (void)refreshViewWithPushDirection:(NSString *)caTransitionSubtype
{
    // Update the header month and year
    _selectedMonthLabel.text = [NSString stringWithFormat:@"%@, %ld", [calendarModel selectedMonthNameE], (long)[calendarModel selectedYear]];
	
	
    if (!caTransitionSubtype) {   // refresh without animation
		[self addButtonArray];
		[self drawCalendarBody];
		
        return;
    }
    
    // Configure the animation for sliding the tiles in
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:0.5f] forKey:kCATransactionAnimationDuration];
    
    CATransition *push = [CATransition animation];
	/*
	 Animation type List
	 
	 - pageCurl
	 - pageUnCurl
	 - suckEffect
	 - spewEffect
	 - cameraIris
	 - cameraIrisHollowOpen
	 - unGenieEffect
	 - cameraIrisHollowClose
	 - genieEffect
	 - rippleEffect
	 - twist
	 - tubey
	 - swirl
	 - charminUltra
	 - zoomIn
	 - zoomOut
	 - oglFlip
	 */
	/*	
	 - Common Transition Types
	 NSString * const kCATransitionFade;
	 NSString * const kCATransitionMoveIn;
	 NSString * const kCATransitionPush;
	 NSString * const kCATransitionReveal;
	 
	 -Common Transition Subtypes
	 NSString * const kCATransitionFromRight;
	 NSString * const kCATransitionFromLeft;
	 NSString * const kCATransitionFromTop;
	 NSString * const kCATransitionFromBottom;
	 */
	
	
	
	[push setType:@"pageCurl"];
	//    push.type = kCATransitionPush;
    push.subtype = caTransitionSubtype;
	
    [self.calendarContainer.layer addAnimation:push forKey:kCATransition];
    [self removeAllButtons];
	[self addButtonArray];
	[self drawCalendarBody];
    
    [CATransaction commit];
	
}

- (void)removeAllButtons {
	for (NSInteger i = 0; i < [self.dateButtons count]; i++) {
		//		UIButton *lDateButton = [self.dateButtons objectAtIndex:i];
//		[[self.dateButtons objectAtIndex:i] retain];
		[[self.dateButtons objectAtIndex:i] removeFromSuperview];
		
	}
	[self.dateButtons removeAllObjects];
	//	Debug(@"removeAllButtons - dateButtons.retainCout = %d", [dateButtons retainCount]);	
	[self.dates removeAllObjects];
}

- (void)addButtonArray {
	
	NSInteger prevMonthDays = [[calendarModel daysInFinalWeekOfPreviousMonth] count];
	NSInteger currentMonthDays = [[calendarModel daysInSelectedMonth] count];
	//	NSInteger nextMonthDays = [[calendarModel daysInFirstWeekOfFollowingMonth] count];
	
	[self.dates addObjectsFromArray:[calendarModel daysInFinalWeekOfPreviousMonth]];
	[self.dates addObjectsFromArray:[calendarModel daysInSelectedMonth]];
	[self.dates addObjectsFromArray:[calendarModel daysInFirstWeekOfFollowingMonth]];
	
//	Debug(@"lArr = %@", lArr);
	//	
	NSInteger i = 0;
	
	for (KLDate *date in self.dates) {
		CalendarButton *lDateButton = [CalendarButton buttonWithType:UIButtonTypeCustom];
		MCLunarDate *lunarDate = [calendarModel sol2lunYear:[date yearOfCommonEra] Month:[date monthOfYear] Day:[date dayOfMonth]];	
		[lDateButton setKlDate:date];		
		[lDateButton setLunarDate:lunarDate];
		//이벤트 데이터 불러오기 ////////////////////////////////////////////////////////////////		
		NSInteger y = [date yearOfCommonEra];
		NSInteger m = [date monthOfYear];
		NSInteger d = [date dayOfMonth];
		
		
		//inputFormatter 에 지정한 형식대로 NSDate 가 생성된다.
		NSString *holy = @"OFF";	
		NSString *lunar = @"OFF";
		NSInteger badgeCount = 0;

		
		//날짜 타이틀 세팅	
		lDateButton.titleLabel.shadowOffset = CGSizeMake(1.0, 0.0);			
		lDateButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		
		[lDateButton setTitle:[NSString stringWithFormat:@"%d", [date dayOfMonth]] forState:UIControlStateNormal];
		
		if (i < prevMonthDays || i >= (prevMonthDays + currentMonthDays)) {
//			lunarLabel.textColor = [UIColor lightGrayColor];
			[lDateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
			
			if (i < prevMonthDays) {
				[lDateButton addTarget:self action:@selector(showPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
			} else {
				[lDateButton addTarget:self action:@selector(showFollowingMonth) forControlEvents:UIControlEventTouchUpInside];
			}
			
		} else {					
			[lDateButton addTarget:self action:@selector(selectedDateButton:) forControlEvents:UIControlEventTouchUpInside];
			if (i % 7 == 0) {
				[lDateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
			} else if (i % 7 == 6) {
				[lDateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
			} else {
				[lDateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			}		
		}
/*
		if (isP && isC && isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETA.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EA.png"] forState:UIControlStateNormal];	
			}
		} else if (isP && !isC && !isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETP.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EP.png"] forState:UIControlStateNormal];	
			}
		} else if (isP && isC && !isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETGP.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EGP.png"] forState:UIControlStateNormal];	
			}
		} else if (isP && !isC && isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETPL.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EPL.png"] forState:UIControlStateNormal];	
			}
		} else if (!isP && isC && isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETGL.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EGL.png"] forState:UIControlStateNormal];	
			}
		} else if (!isP && isC && !isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETG.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EG.png"] forState:UIControlStateNormal];	
			}
		} else if (!isP && !isC && isL) {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"ETL.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"EL.png"] forState:UIControlStateNormal];	
			}
		} else {
			if ([date isToday]) {			
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"TE.png"] forState:UIControlStateNormal];
			} else {	
				[lDateButton setBackgroundImage:[UIImage imageNamed:@"E.png"] forState:UIControlStateNormal];	
			}
		}
*/		

		if ([date isToday]) {			
//			[lDateButton setBackgroundImage:[UIImage imageNamed:@"t.png"] forState:UIControlStateNormal];
            lDateButton.backgroundColor = [UIColor redColor];
		} else {	
//			[lDateButton setBackgroundImage:[UIImage imageNamed:@"E.png"] forState:UIControlStateNormal];	
		}

		
		//음력 명절 설정		///////////////////////////////////////////////////////////////////////////////////////////
		[lDateButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		lDateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		lDateButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
		
		[self.dateButtons addObject:lDateButton];
//		[lDateButton release];

		i++;
	}
}

- (void)drawCalendarBody {
	NSInteger row = 0;
	NSInteger col = 0;
	NSInteger i = 0;
	
	UIView *container = nil;
	CalendarButton *lDateButton = nil;
	for (lDateButton in self.dateButtons) {
		lDateButton.frame = CGRectMake(col * ldButtonWidth, row * ldButtonHeight + (ldButtonHeight + 2 + HEADER_Y + ((self.bounds.size.height / 1000) * ldButtonHeight)), ldButtonWidth, ldButtonHeight);

        lDateButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
		[self.calendarContainer addSubview:lDateButton];
		col++;
		if (col == 7) {
			row++;
			col = 0;
		}
		i++;
	}	
	[lDateButton release];
}

-(void)redrawSelf
{
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	[super drawRect:rect];
//	UIImage *img = [UIImage imageNamed: @"main_background.png"];
//	[img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
}

#pragma mark -
#pragma mark Date Formatter

- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	return dateFormatter;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[dates release];
	[dateButtons release];
	[self.calendarContainer release];
    [headerView release];
    [dayNameView release];
    
	[calendarModel release];
	[_selectedMonthLabel release];

	[shootingDatas release];
	[dateFormatter release];
	
	[calendarContainer release];
	
	[annData release];
	[tempData release];
    
    [bgView release];
	
    [super dealloc];
}


@end
