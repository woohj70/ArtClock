//
//  SkyAndTreeViewController.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 24..
//  Copyright 2011 Mazdah.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtClockAppDelegate.h"

@class SunAndMoonViewController;
@class SkyAndStarsViewController;
@class SunAndEarthViewcontroller;

@interface SkyAndTreeViewController : UIViewController {
    SunAndMoonViewController *smViewController;
    SkyAndStarsViewController *ssViewController;
    SunAndEarthViewcontroller *seViewController;
}

@property (nonatomic, retain) SunAndMoonViewController *smViewController;
@property (nonatomic, retain) SkyAndStarsViewController *ssViewController;
@property (nonatomic, retain) SunAndEarthViewcontroller *seViewController;

@end
