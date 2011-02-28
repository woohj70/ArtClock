//
//  RootViewController.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 25..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtClockAppDelegate.h"

//#import "SunAndMoonViewController.h"
//#import "SkyAndStarsViewController.h"
//#import "SunAndEarthViewcontroller.h"
//#import "SkyAndTreeViewController.h"

#import "MyCalendarView.h"

@interface RootViewController : UIViewController <MyCalendarViewDelegate> {
/*
    SkyAndStarsViewController *ssViewController;
    SunAndEarthViewcontroller *seViewController;
    SkyAndTreeViewController *stViewController;
    SunAndMoonViewController *smViewController;
*/
  
    UIImageView *bgImageView;
    MyCalendarView *calView;

}

/*
@property (nonatomic, retain) SkyAndStarsViewController *ssViewController;
@property (nonatomic, retain) SunAndEarthViewcontroller *seViewController;
@property (nonatomic, retain) SkyAndTreeViewController *stViewController;
@property (nonatomic, retain) SunAndMoonViewController *smViewController;
*/

@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
@property (nonatomic, retain)  MyCalendarView *calView;


@end
