/*
 * Copyright (c) 2008, Keith Lazuka, dba The Polypeptides
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *	- Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *	- Neither the name of the The Polypeptides nor the
 *	  names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY Keith Lazuka ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL Keith Lazuka BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import <UIKit/UIKit.h>
#import "MCLunarDate.h"
#import "MCSolarDate.h"

@class THCalendarInfo;

@interface KLCalendarModel : NSObject {
    CFCalendarRef _cal;
    THCalendarInfo *_calendarInfo;
    NSArray *_dayNames;
	NSArray *_dayNamesE;
	NSArray *_lunarDates;
	
	NSArray *_info_gan;
	NSArray *_info_gan2;
	NSArray *_info_gee;
	NSArray *_info_gee2;
	NSArray *_info_ddi;
	NSArray *_info_week;
	NSArray *_info_week2;
}

- (void)decrementMonth;
- (void)incrementMonth;
- (void)decrementYear;
- (void)incrementYear;
- (MCLunarDate *)sol2lunYear:(NSInteger) Year Month:(NSInteger) Month Day:(NSInteger) Day;
- (MCSolarDate *)lun2solYear:(NSInteger) Year Month:(NSInteger) Month Day:(NSInteger) Day Leaf:(BOOL)Leaf;

- (NSString *)selectedMonthName;
- (NSInteger)selectedMonthNumberOfWeeks;
- (NSInteger)selectedYear;
- (NSString *)dayNameAbbreviationForDayOfWeek:(NSUInteger)dayOfWeek;

- (NSArray *)daysInFinalWeekOfPreviousMonth;
- (NSArray *)daysInSelectedMonth;
- (NSArray *)daysInFirstWeekOfFollowingMonth;

@end
