//
//  LunarDate.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-18.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarDate.h"

static const int LunarMonthDaysTable[] = {
    0x4ae0, 0xa570, 0x5268, 0xd260, 0xd950, 0x6aa8, 0x56a0, 0x9ad0, 0x4ae8, 0x4ae0, // 1910
    0xa4d8, 0xa4d0, 0xd250, 0xd548, 0xb550, 0x56a0, 0x96d0, 0x95b0, 0x49b8, 0x49b0, // 1920
    0xa4b0, 0xb258, 0x6a50, 0x6d40, 0xada8, 0x2b60, 0x9570, 0x4978, 0x4970, 0x64b0, // 1930
    0xd4a0, 0xea50, 0x6d48, 0x5ad0, 0x2b60, 0x9370, 0x92e0, 0xc968, 0xc950, 0xd4a0, // 1940
    0xda50, 0xb550, 0x56a0, 0xaad8, 0x25d0, 0x92d0, 0xc958, 0xa950, 0xb4a8, 0x6ca0, // 1950
    0xb550, 0x55a8, 0x4da0, 0xa5b0, 0x52b8, 0x52b0, 0xa950, 0xe950, 0x6aa0, 0xad50, // 1960
    0xab50, 0x4b60, 0xa570, 0xa570, 0x5260, 0xe930, 0xd950, 0x5aa8, 0x56a0, 0x96d0, // 1970
    0x4ae8, 0x4ad0, 0xa4d0, 0xd268, 0xd250, 0xd528, 0xb540, 0xb6a0, 0x96d0, 0x95b0, // 1980
    0x49b0, 0xa4b8, 0xa4b0, 0xb258, 0x6a50, 0x6d40, 0xada0, 0xab60, 0x9370, 0x4978, // 1990
    0x4970, 0x64b0, 0x6a50, 0xea50, 0x6b28, 0x5ac0, 0xab60, 0x9368, 0x92e0, 0xc960, // 2000
    0xd4a8, 0xd4a0, 0xda50, 0x5aa8, 0x56a0, 0xaad8, 0x25d0, 0x92d0, 0xc958, 0xa950, // 2010
    //TODO
    0xb4a0, 0xb550, 0xb550, 0x55a8, 0x4ba0, 0xa5b0, 0x52b8, 0x52b0, 0xa930, 0x74a8, // 2020
    0x6aa0, 0xad50, 0x4da8, 0x4b60, 0x9570, 0xa4e0, 0xd260, 0xe930, 0xd530, 0x5aa0, // 2030
    0x6b50, 0x96d0, 0x4ae8, 0x4ad0, 0xa4d0, 0xd258, 0xd250, 0xd520, 0xdaa0, 0xb5a0, // 2040
    0x56d0, 0x4ad8, 0x49b0, 0xa4b8, 0xa4b0, 0xaa50, 0xb528, 0x6d20, 0xada0, 0x55b0 // 2050
};
static const char SolarLunarOffsetTable[] =  {
    49, 38, 28, 46, 34, 24, 43, 32, 21, 40, // 1910
    29, 48, 36, 25, 44, 34, 22, 41, 31, 50, // 1920
    38, 27, 46, 35, 23, 43, 32, 22, 40, 29, // 1930
    47, 36, 25, 44, 34, 23, 41, 30, 49, 38, // 1940
    26, 45, 35, 24, 43, 32, 21, 40, 28, 47, // 1950
    36, 26, 44, 33, 23, 42, 30, 48, 38, 27, // 1960
    45, 35, 24, 43, 32, 20, 39, 29, 47, 36, // 1970
    26, 45, 33, 22, 41, 30, 48, 37, 27, 46, // 1980
    35, 24, 43, 32, 50, 39, 28, 47, 36, 26, // 1990
    45, 34, 22, 40, 30, 49, 37, 27, 46, 35, // 2000
    23, 42, 31, 21, 39, 28, 48, 37, 25, 44, // 2010
    33, 23, 41, 31, 50, 39, 28, 47, 35, 24, // 2020
    42, 30, 21, 40, 28, 47, 36, 25, 43, 33, // 2030
    22, 41, 30, 49, 37, 26, 44, 33, 23, 42, // 2040
    31, 21, 40, 29, 47, 36, 25, 44, 32, 22, // 2050
};

static const char LunarLeapMonthTable[] = {0x00, 0x50, 0x04, 0x00, 0x20, // 1910
    0x60, 0x05, 0x00, 0x20, 0x70, // 1920
    0x05, 0x00, 0x40, 0x02, 0x06, // 1930
    0x00, 0x50, 0x03, 0x07, 0x00, // 1940
    0x60, 0x04, 0x00, 0x20, 0x70, // 1950
    0x05, 0x00, 0x30, 0x80, 0x06, // 1960
    0x00, 0x40, 0x03, 0x07, 0x00, // 1970
    0x50, 0x04, 0x08, 0x00, 0x60, // 1980
    0x04, 0x0a, 0x00, 0x60, 0x05, // 1990
    0x00, 0x30, 0x80, 0x05, 0x00, // 2000
    0x40, 0x02, 0x07, 0x00, 0x50, // 2010
    0x04, 0x09, 0x00, 0x60, 0x04, // 2020
    0x00, 0x20, 0x60, 0x05, 0x00, // 2030
    0x30, 0xb0, 0x06, 0x00, 0x50, // 2040
    0x02, 0x07, 0x00, 0x50, 0x03 // 2050
};


 
static NSString * const CHINESE_NUM[] = {
    @"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十"
};
static NSString * const HeavenlyStems[] = {@"甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"};

static NSString * const EarthlyBranches[] = {@"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"};


 

@implementation LunarDate

@synthesize lunarYear = _lunarYear;
@synthesize lunarMonth = _lunarMonth;
@synthesize lunarDay = _lunarDay;
@synthesize solarYear = _solarYear;
@synthesize solarMonth = _solarMonth;
@synthesize solarDay = _solarDay;

//1
+ (BOOL) isLeapYear:(NSInteger)solarYear{
    return (((solarYear % 4 == 0) && (solarYear % 100 != 0)) || solarYear % 400 == 0)?YES:NO; 
}

//2
+ (NSInteger) lunarLeapMonth: (NSInteger) lunarYear{
    char iMonth = LunarLeapMonthTable[(lunarYear - 1901) / 2];     
    return lunarYear % 2 == 0 ? (iMonth & 0X0F) : ( (iMonth & 0xf0) >> 4 );     
}

//3

 

+ (NSInteger) lunarMonthDaysWith: (NSInteger) iYear month:(NSInteger) iMonth{
    NSInteger iLeapMonth = [self lunarLeapMonth:iYear];
    if (((iMonth > 12) && (iMonth - 12 != iLeapMonth)) || (iMonth < 0)) { 
        return -1;
    }
    if (iMonth - 12 == iLeapMonth) {
         if ((LunarMonthDaysTable[iYear - 1901] & (0x8000 >> iLeapMonth)) == 0) {
             return 29;
        } else {
             return 30;
        }
    }
    if ((iLeapMonth > 0) && (iMonth > iLeapMonth)) {
        iMonth++;
    }
    if ((LunarMonthDaysTable[iYear - 1901] & (0x8000 >> (iMonth - 1))) == 0) {
        return 29;
    } else {
        return 30;
    }
    
    return 0;
}

//4
+ (NSInteger) getLunarNewYearOffsetDays:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger) iDay{
    
    NSInteger iOffsetDays = 0;
    NSInteger iLeapMonth = [self lunarLeapMonth:iYear];
    if ((iLeapMonth > 0) && (iLeapMonth == iMonth - 12)) {
        iMonth = iLeapMonth;
        iOffsetDays += [self lunarMonthDaysWith:iYear month:iMonth] ;
    }
    for (NSInteger i = 1; i < iMonth; i++) {
        iOffsetDays += [self lunarMonthDaysWith:iYear month:i] ;
        if (i == iLeapMonth) {
            iOffsetDays += [self lunarMonthDaysWith:iYear month:(iLeapMonth + 12)];
        }
    }
    iOffsetDays += iDay - 1;
    return iOffsetDays;
}

//5
+ (NSInteger) dayInMonth:(NSInteger)iMonth withYear:(NSInteger) iYear{
    if ((iMonth == 1) || (iMonth == 3) || (iMonth == 5) || (iMonth == 7) || (iMonth == 8) || (iMonth == 10) || (iMonth == 12)) {
        return 31;
    } else if ((iMonth == 4) || (iMonth == 6) || (iMonth == 9) || (iMonth == 11)) {
        return 30;
    } else if (iMonth == 2) {
        if ([self isLeapYear:iYear]) {
            return 29;
        } else {
            return 28;
        }
    } else {
        return 0;
    }
    
    
}

//6
+(NSInteger) getSolarNewYearOffsetDays:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger) iDay {
    NSInteger iOffsetDays = 0;
    for (NSInteger month = 1; month < iMonth; month++) {
        iOffsetDays +=  [self dayInMonth:month withYear:iYear];
    }
    iOffsetDays += ( iDay - 1 );
    return iOffsetDays;
}



+ (NSInteger) lunarMonth:(NSInteger)lunarYear withMonthOffset:(NSInteger) offset
{
    NSInteger month = offset + 1;
    NSInteger leapMonth = [LunarDate lunarLeapMonth:lunarYear];
    if(leapMonth){
        if( month - 1== leapMonth ){
            return leapMonth + 12;
        }else if(month > leapMonth){
            return month - 1;
        }
        
    }
    return month;     
}

+ (NSString*) dayDescription:(NSInteger) day
{
    NSString *name = CHINESE_NUM[day % 10]; 
    if (day > 29) {
       return @"三十";
    } else if (day > 20) {
        return  [NSString stringWithFormat:@"廿%@", name];
    } else if (day == 20) {
         return @"二十";
    } else if (day > 10) {
        return  [NSString stringWithFormat:@"十%@", name];
    } else if (day == 10) {
        return @"初十";
    } else {
        return  [NSString stringWithFormat:@"初%@", name];
    }
    
    return  @"";
}

+ (NSString *) monthDescription:(NSInteger) month
{
   // NSLog(@"月份%d", month);
    NSMutableString * label = [[NSMutableString alloc]init];
    if (month > 12) {
        month -= 12;
        [label appendString:@"闰"];
    }
    if (month == 12) {
         [label appendString:@"腊月"];

    } else if (month == 11) {
         [label appendString:@"冬月"];

    } else if (month == 1) {
         [label appendString:@"正月"];

    } else {
         [label appendFormat:@"%@月", CHINESE_NUM[month]];
    }
    
    return [label description];
}

+ (NSString *) monthDescription:(NSInteger) monthOffset withYear:(NSInteger) year
{
    NSInteger month =  [self lunarMonth:year withMonthOffset:monthOffset];
    return [self monthDescription:month];
}

+ (NSString *) yearDescription:(NSInteger) year isFullLabel:(BOOL) fullLabel
{
    if(fullLabel){
        NSInteger temp = ABS(year - 1924);  
        return   [NSString stringWithFormat:@"%@%@%@%@ (%@%@)年", CHINESE_NUM[year / 1000], CHINESE_NUM[year % 1000 / 100], CHINESE_NUM[year % 100 / 10], CHINESE_NUM[year % 10],HeavenlyStems[temp % 10] , EarthlyBranches[temp % 12]];   
        
    }
  
    return   [NSString stringWithFormat:@"%@%@%@%@", CHINESE_NUM[year / 1000], CHINESE_NUM[year % 1000 / 100], CHINESE_NUM[year % 100 / 10], CHINESE_NUM[year % 10] ];   

}


+ (id) lunarDateWithLunarYear:(NSInteger)iYear lunarMonth:(NSInteger)iMonth andLunarDay:(NSInteger)iDay
{
    return [[LunarDate alloc] initWithLunar:iYear month:iMonth day:iDay];
}


- (id) initWithLunar:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger)iDay
{
    self = [super init];
    if(self){ 
        NSInteger iSYear, iSMonth, iSDay;
        NSInteger iOffsetDays = [LunarDate getLunarNewYearOffsetDays:iYear month:iMonth day:iDay] + SolarLunarOffsetTable[iYear - 1901];
        NSInteger iYearDays = [LunarDate isLeapYear:iYear] ? 366 : 365;
        if (iOffsetDays >= iYearDays) {
            iSYear = iYear + 1;
            iOffsetDays -= iYearDays;
        } else {
            iSYear = iYear;
        }
        iSDay = iOffsetDays + 1;
        for (iSMonth = 1; iOffsetDays >= 0; iSMonth++) {
            iSDay = iOffsetDays + 1;
            iOffsetDays -= [LunarDate dayInMonth:iSMonth withYear:iSYear];
        }
        iSMonth--;  
        NSLog(@"init with Lunar ");

        self =  [self initWithSolarYear:iSYear solarMonth:iSMonth solarDay:iSDay lunarYear:iYear lunarMonth:iMonth lunarDay:iDay];          
    }
    
    return self;

   // [NSDate 
   // return [NSDate dateWithString:dateString];
    
}


- (id) initWithSolarYear:(NSInteger)iYear solarMonth:(NSInteger)iMonth solarDay:(NSInteger)iDay  lunarYear:(NSInteger)iLYear lunarMonth:(NSInteger)iLMonth lunarDay:(NSInteger)iLDay
{
    self = [super init];
    if(self){
        _lunarYear = iLYear;
        _lunarMonth = iLMonth;
        _lunarDay = iLDay;
        _solarYear = iYear;
        _solarMonth = iMonth;
        _solarDay = iDay;
        NSLog(@"公历 %d-%d-%d 农历 %d-%d-%d", _solarYear, _solarMonth, _solarDay, _lunarYear ,_lunarMonth,_lunarDay );
    }

    return self;
    
}
 

- (id) initWithSolar:(NSInteger)iYear month:(NSInteger)iMonth day:(NSInteger)iDay
{
    self = [super init];
    if(self){ 
        
        int iLDay, iLMonth, iLYear;
        int iOffsetDays = [LunarDate getSolarNewYearOffsetDays:iYear month:iMonth day:iDay];
        int iLeapMonth = [LunarDate lunarLeapMonth:iYear];
        if (iOffsetDays < SolarLunarOffsetTable[iYear - 1901]) {
            iLYear = iYear - 1;
            iOffsetDays = SolarLunarOffsetTable[iYear - 1901] - iOffsetDays;
            iLDay = iOffsetDays;
            for (iLMonth = 12; iOffsetDays > [LunarDate lunarMonthDaysWith:iLYear month:iLMonth]; iLMonth--) {
                iLDay = iOffsetDays;
                iOffsetDays -= [LunarDate lunarMonthDaysWith:iLYear month:iLMonth];
            }
            if (0 == iLDay) {
                iLDay = 1;
            } else {
                iLDay = [LunarDate lunarMonthDaysWith:iLYear month:iLMonth] - iOffsetDays + 1;
            }
        } else {
            iLYear = iYear;
            iOffsetDays -= SolarLunarOffsetTable[iYear - 1901];
            iLDay = iOffsetDays + 1;
            for (iLMonth = 1; iOffsetDays >= 0; iLMonth++) {
                iLDay = iOffsetDays + 1;
                iOffsetDays -= [LunarDate lunarMonthDaysWith:iLYear month:iLMonth] ;
                if ((iLeapMonth == iLMonth) && (iOffsetDays > 0)) {
                    iLDay = iOffsetDays;
                    iOffsetDays -= [LunarDate lunarMonthDaysWith:iLYear month:iLMonth+12] ;
                    if (iOffsetDays <= 0) {
                        iLMonth += ( 12 + 1 );
                        break;
                    }
                }
            }
            iLMonth--;
        }

        NSLog(@"init with solar ");
      self =  [self initWithSolarYear:iYear solarMonth:iMonth solarDay:iDay lunarYear:iLYear lunarMonth:iLMonth lunarDay:iLDay];         
        
        //[NSString stringWithFormat: ];
    }
    
    return self;
}




- (NSString *) lunarDescription
{
    return [NSString stringWithFormat:@"%@%@%@",[LunarDate yearDescription:[self lunarYear] isFullLabel:TRUE], 
            [LunarDate monthDescription:[self lunarMonth]],[LunarDate dayDescription:[self lunarDay]]];
}


+ (LunarDate *) lunarDateWithDate:(NSDate *)curentDate{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* compo = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:curentDate]; // Get necessary date components
    return [[LunarDate alloc]initWithSolar:[compo year] month:[compo month] day:[compo day]];
    
}

@end
