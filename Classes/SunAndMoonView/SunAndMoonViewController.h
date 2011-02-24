//
//  SunAndMoonViewController.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 24..
//  Copyright 2011 Mazdah.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtClockAppDelegate.h"

@class SkyAndStarsViewController;
@class SunAndEarthViewcontroller;
@class SkyAndTreeViewController;


@interface SunAndMoonViewController : UIViewController {
    SkyAndStarsViewController *ssViewController;
    SunAndEarthViewcontroller *seViewController;
    SkyAndTreeViewController *stViewController;
}

@property (nonatomic, retain) SkyAndStarsViewController *ssViewController;
@property (nonatomic, retain) SunAndEarthViewcontroller *seViewController;
@property (nonatomic, retain) SkyAndTreeViewController *stViewController;

@end
