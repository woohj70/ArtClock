//
//  TextBasedDigitalClockView.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 1..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextBasedDigitalClockView : UIView {
    UIImageView *bgView;
    NSTimer *timeTimer;
    UILabel *timeText;
    UILabel *ampmText;
}

@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) NSTimer *timeTimer;
@property (nonatomic, retain) UILabel *timeText;
@property (nonatomic, retain) UILabel *ampmText;

- (void) startClockProcessor;
- (void)resizeClock:(CGRect)frame;

@end
