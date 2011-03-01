//
//  CustomClock.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 1..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomClock : UIViewController {
    UIView *digitalClockWithTextView;
    
    NSTimer *timeTimer;
    UILabel *time;
}

@property (nonatomic, retain) IBOutlet UIView *digitalClockWithTextView;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) NSTimer *timeTimer;

@end
