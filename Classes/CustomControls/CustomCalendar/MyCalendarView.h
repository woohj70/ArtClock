//
//  MyCalendarView.h
//  MyCalendarTest
//
//  Created by HYOUNG JUN WOO on 10. 4. 18..
//  Copyright 2010 Mazdah.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "KLDate.h"
#import "MCLunarDate.h"
#import "CalendarButton.h"
#import "THCalendarInfo.h"

#define KL_CHANGE_MONTH_BUTTON_WIDTH    44.0f
#define KL_CHANGE_MONTH_BUTTON_HEIGHT   32.0f
#define KL_SELECTED_MONTH_WIDTH        200.0f
#define KL_HEADER_HEIGHT                27.0f
#define KL_HEADER_FONT_SIZE             (KL_HEADER_HEIGHT-6.0f)
#define HEADER_Y						5.0f

@class KLCalendarModel;

@protocol MyCalendarViewDelegate;

@interface MyCalendarView : UIView<UIAlertViewDelegate> {
	IBOutlet id <MyCalendarViewDelegate> delegate;
	NSMutableArray *dateButtons;
	NSMutableArray *dates;
	KLCalendarModel *calendarModel;
	UILabel *_selectedMonthLabel;
	UIView *calendarContainer;
    UIView *headerView;
    UIView *dayNameView;
	//	UIView *container;
	
	NSMutableArray *shootingDatas;
	
	NSDateFormatter *dateFormatter;
	
	NSMutableDictionary *annData;
	NSMutableDictionary *tempData;
    
    float ldButtonHeight;
    float ldButtonWidth;
    float fontSize;
    
    UIImageView *bgView;
}

@property(nonatomic, assign) id <MyCalendarViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *dateButtons;
@property (nonatomic, retain) NSMutableArray *dates;
@property (nonatomic, retain) UIView *calendarContainer;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *dayNameView;
@property (nonatomic, retain) UIImageView *bgView;

@property (nonatomic, retain) NSMutableArray *shootingDatas;
@property (nonatomic, retain) NSArray *anniversaryDatas;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
//@property (nonatomic, retain) UIView *container;

//- (id)initWithImage:(UIImage *)image delegate:(id <MyCalendarViewDelegate>)delegate;
- (id)initWithFrame:(CGRect)frame  delegate:(id <MyCalendarViewDelegate>)aDelegate;
- (void)drawCalendarHead;
- (void)drawCalendarBody;
- (void)removeAllButtons;
- (void)addButtonArray;
- (void)selectedDateButton:(UIButton *)dateButton;

@end

@protocol MyCalendarViewDelegate <NSObject>
@required
- (void)popupView:(CalendarButton *)dateButton;
@optional
- (void)wasSwipedToTheLeft;
- (void)wasSwipedToTheRight;
@end