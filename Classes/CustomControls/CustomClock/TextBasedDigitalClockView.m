//
//  TextBasedDigitalClockView.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 1..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import "TextBasedDigitalClockView.h"


@implementation TextBasedDigitalClockView

@synthesize bgView;
@synthesize timeTimer;
@synthesize timeText, ampmText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
        bgView.image = [UIImage imageNamed:@"clockbg.png"];
        [self addSubview:bgView];
 //       [bgView release];
        
        timeText = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.bounds.size.width - 10, self.bounds.size.height - 10)];
        timeText.textAlignment = UITextAlignmentCenter;
        float fontSize = (self.bounds.size.width * 20 / 100);
        timeText.font = [UIFont fontWithName:@"LCD" size:fontSize];
        timeText.textColor = [UIColor cyanColor];
        timeText.backgroundColor = [UIColor clearColor];
        [self addSubview:timeText];
        
        ampmText = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.height * 8 / 100), (self.bounds.size.height * 5 / 100), self.bounds.size.width / 5, self.bounds.size.height / 3)];
        ampmText.textAlignment = UITextAlignmentLeft;
        fontSize = (self.bounds.size.width * 7 / 100);
        ampmText.font = [UIFont fontWithName:@"LCD" size:fontSize];
        ampmText.textColor = [UIColor cyanColor];
        ampmText.backgroundColor = [UIColor clearColor];
        [self addSubview:ampmText];
    }
    return self;
}

#pragma mark - Resize Method

- (void)resizeClock:(CGRect)frame {
    self.frame = frame;
    
    [bgView removeFromSuperview];
    bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)] autorelease];
    bgView.image = [UIImage imageNamed:@"clockbg.png"];
    [self addSubview:bgView];
    //       [bgView release];
    
    [timeText removeFromSuperview];
    
    timeText = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.bounds.size.width - 10, self.bounds.size.height - 10)];
    timeText.textAlignment = UITextAlignmentCenter;
    float fontSize = (self.bounds.size.width * 20 / 100);
    timeText.font = [UIFont fontWithName:@"LCD" size:fontSize];
    timeText.textColor = [UIColor cyanColor];
    timeText.backgroundColor = [UIColor clearColor];
    [self addSubview:timeText];
    
    [ampmText removeFromSuperview];
    ampmText = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.height * 8 / 100), (self.bounds.size.height * 5 / 100), self.bounds.size.width / 5, self.bounds.size.height / 3)];
    ampmText.textAlignment = UITextAlignmentLeft;
    fontSize = (self.bounds.size.width * 7 / 100);
    ampmText.font = [UIFont fontWithName:@"LCD" size:fontSize];
    ampmText.textColor = [UIColor cyanColor];
    ampmText.backgroundColor = [UIColor clearColor];
    [self addSubview:ampmText];
}

#pragma mark - Clock Processor

- (void) startClockProcessor {
    timeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetClock) userInfo:nil repeats:YES];
}

- (void) resetClock {
	NSDate *t = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
	
	NSString *timeValue = [formatter stringFromDate:t];
	self.timeText.text = timeValue;
    
    [formatter setDateFormat:@"a"];
    self.ampmText.text = [formatter stringFromDate:t];
	[formatter release];
	
	if ([timeValue isEqualToString:@"00:00:00"]) {
//		[self changeDate];
	}
	
    //    self.freeMemInfo.text = [NSString stringWithFormat:@"%d Mb", [ShootingMyDayAppDelegate printMemoryStatus]];
    /*    
     if (self.isStopWatchStart) {
     
     //         second++;
     
     //         if (second == 60) {
     //         minute++;
     //         second = 0;
     //         }
     
     //         if (minute == 60) {
     //         hour++;
     //         minute = 0;
     //         }
     
     
     CFTimeInterval millis = CACurrentMediaTime() - startT;
     //		int mil = (int)(millis * 1000) % 1000;
     second = (int)millis % 60;
     //		int sec1 = mil / 100;
     minute = (int)millis % 3600 / 60;
     hour = (int)millis / 3600;
     
     NSString *secStr = nil;
     NSString *minStr = nil;
     NSString *hStr = nil;
     
     
     if (second < 10) {
     secStr = [NSString stringWithFormat:@"0%d", second];
     } else {
     secStr = [NSString stringWithFormat:@"%d", second];
     }
     
     if (minute < 10) {
     minStr = [NSString stringWithFormat:@"0%d", minute];
     } else {
     minStr = [NSString stringWithFormat:@"%d", minute];
     }
     
     if (hour < 10) {
     hStr = [NSString stringWithFormat:@"0%d", hour];
     } else {
     hStr = [NSString stringWithFormat:@"%d", hour];
     }
     
     
     self.stopWatch.text = [NSString stringWithFormat:@"%@ : %@ : %@", hStr, minStr, secStr];
     }
     */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - View lifecycle

- (void)dealloc
{
    [bgView release];
    [timeTimer release];
    [timeText release];
    [ampmText release];
    [super dealloc];
}

@end
