//
//  CustomClock.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 1..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import "CustomClock.h"


@implementation CustomClock

@synthesize digitalClockWithTextView;

@synthesize timeTimer;
@synthesize time;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
	self.time.text = timeValue;
	[formatter release];
	
	if ([timeValue isEqualToString:@"00:00:00"]) {
		[self changeDate];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [digitalClockWithTextView release];
    
    [timeTimer release];
    [time release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
