//
//  LunarDate.h
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-18.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAX_LUNAR_YEAR  2049
#define MIN_LUNAR_YEAR  2008
#define LUNAR_YEAR_INDEX 0
#define LUNAR_MONTH_INDEX 1
#define LUNAR_DAY_INDEX  2

@interface LunarDate : NSObject
{
    
}
@property(nonatomic,readonly) NSInteger lunarYear, lunarMonth, lunarDay, solarYear, solarMonth, solarDay;

+ (BOOL) isLeapYear:(NSInteger)solarYear;
+ (NSInteger) lunarLeapMonth: (NSInteger) lunarYear;
+ (NSInteger) lunarMonthDaysWith: (NSInteger) lunarYear month:(NSInteger) lunarMonth;
+ (NSInteger) lunarMonth:(NSInteger)lunarYear withMonthOffset:(NSInteger) offset;
+ (NSString*) dayDescription:(NSInteger) day;
+ (NSString *) monthDescription:(NSInteger) month;
+ (NSString *) monthDescription:(NSInteger) monthOffset withYear:(NSInteger) year;
+ (NSString *) yearDescription:(NSInteger) year isFullLabel:(BOOL) fullLabel;
+ (id) lunarDateWithLunarYear:(NSInteger)iYear lunarMonth:(NSInteger)iMonth andLunarDay:(NSInteger)iDay;

+ (NSInteger) lunarMonthDaysWith: (NSInteger) iYear month:(NSInteger) iMonth;
+ (LunarDate *) lunarDateWithDate:(NSDate *)curentDate;
- (id) initWithSolar:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger)iDay;
- (id) initWithLunar:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger)iDay;
- (NSString *) lunarDescription;

@end
