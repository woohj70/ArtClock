//
//  RootViewController.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 25..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtClockAppDelegate.h"

#import "SunAndMoonViewController.h"
#import "SkyAndStarsViewController.h"
#import "SunAndEarthViewcontroller.h"
#import "SkyAndTreeViewController.h"

@interface RootViewController : UIViewController {
    SkyAndStarsViewController *ssViewController;
    SunAndEarthViewcontroller *seViewController;
    SkyAndTreeViewController *stViewController;
    SunAndMoonViewController *smViewController;
}

@property (nonatomic, retain) SkyAndStarsViewController *ssViewController;
@property (nonatomic, retain) SunAndEarthViewcontroller *seViewController;
@property (nonatomic, retain) SkyAndTreeViewController *stViewController;
@property (nonatomic, retain) SunAndMoonViewController *smViewController;

@end
