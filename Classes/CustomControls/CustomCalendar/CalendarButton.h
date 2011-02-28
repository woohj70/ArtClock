//
//  CalendarButton.h
//  iPhotoDiary
//
//  Created by HYOUNG JUN WOO on 10. 5. 11..
//  Copyright 2010 Mazdah.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLDate.h"
#import "MCLunarDate.h"
//#import "KLColors.h"


@interface CalendarButton : UIButton {
	KLDate *klDate;
	MCLunarDate *lunarDate;
	
	NSArray *shootingArray;
	
//	UILabel *lunarLabel;
}

@property(nonatomic, retain) KLDate *klDate;
@property(nonatomic, retain) MCLunarDate *lunarDate;

@property(nonatomic, retain) NSArray *shootingArray;

@end
