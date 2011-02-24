//
//  SkyAndStarsViewController.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 24..
//  Copyright 2011 Mazdah.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtClockAppDelegate.h"

@class SunAndMoonViewController;
@class SunAndEarthViewcontroller;
@class SkyAndTreeViewController;

@interface SkyAndStarsViewController : UIViewController {
    SunAndMoonViewController *smViewController;
    SunAndEarthViewcontroller *seViewController;
    SkyAndTreeViewController *stViewController;
}

@property (nonatomic, retain) SunAndMoonViewController *smViewController;
@property (nonatomic, retain) SunAndEarthViewcontroller *seViewController;
@property (nonatomic, retain) SkyAndTreeViewController *stViewController;

@end
