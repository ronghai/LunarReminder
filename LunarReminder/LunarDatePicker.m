
//
//  LunarDatePicker.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-18.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarDatePicker.h"
#import "LunarDate.h"


@interface LunarDatePicker ()<UIPickerViewDelegate, UIPickerViewDataSource> 

@end
 
@implementation LunarDatePicker
@synthesize datePickerViewDelegate = _datePickerViewDelegate;
@synthesize lunarDate = _lunarDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    self.delegate = self;
    self.dataSource = self;
} 


- (void)awakeFromNib
{
    [self setup]; // get initialized when we come out of a storyboard
}

#pragma mark todo methods


- (void) updatePicker
{
    NSInteger lunarYear  = _lunarDate.lunarYear;
    NSInteger lunarMonth = _lunarDate.lunarMonth;
    NSInteger lunarDay  =  _lunarDate.lunarDay;    
    [self selectRow:(lunarYear - MIN_LUNAR_YEAR) inComponent:LUNAR_YEAR_INDEX animated:FALSE];
    NSInteger lmonth = [LunarDate lunarLeapMonth:lunarYear];    
    if( lmonth == 0  || lunarMonth <= lmonth){
        lunarMonth = lunarMonth - 1;
    }else if(lunarMonth > 12){
        lunarMonth =  lmonth; 
    }   
    [self selectRow:lunarMonth inComponent:LUNAR_MONTH_INDEX animated:FALSE]; 
    [self selectRow:(lunarDay - 1) inComponent:LUNAR_DAY_INDEX animated:FALSE];
}


- (NSInteger) lunarYear
{ 
    return [self selectedRowInComponent:LUNAR_YEAR_INDEX] + MIN_LUNAR_YEAR;
}



- (NSInteger) lunarMonth
{
    return [LunarDate lunarMonth:[self lunarYear] withMonthOffset:[self selectedRowInComponent:LUNAR_MONTH_INDEX]];
}

- (NSInteger) lunarDay
{
    return [self selectedRowInComponent:LUNAR_DAY_INDEX] + 1;
}


#pragma mark lunarDate getter
- (LunarDate *) lunarDate
{
    if(!_lunarDate){
        _lunarDate = [LunarDate lunarDateWithLunarYear:[self lunarYear] lunarMonth:[self lunarMonth] andLunarDay:[self lunarDay]];
    }
    return _lunarDate;
}

 

#pragma mark lunarDate setter
- (void) setLunarDate:(LunarDate *) date{
    if (_lunarDate != date) {
         _lunarDate = date;
       [self updatePicker];
           
    }
    
}


#pragma mark UIPickerViewDataSource
// returns the number of 'columns' to display. 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == LUNAR_YEAR_INDEX ){
        return MAX_LUNAR_YEAR - MIN_LUNAR_YEAR + 1;
    }else if(component == LUNAR_MONTH_INDEX ){
        if([LunarDate lunarLeapMonth:[self lunarYear]]){
            return 13;
        }
        return 12;
    }else if(component == LUNAR_DAY_INDEX ){
        return [LunarDate lunarMonthDaysWith:[self lunarYear] month:[self lunarMonth]];
    }
    
    return 0;
}




#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return [LunarDate yearDescription:row + MIN_LUNAR_YEAR isFullLabel:FALSE];
    }else if(component == LUNAR_MONTH_INDEX ){
        return [LunarDate monthDescription: row withYear:[self lunarYear] ];
    }else if(component == LUNAR_DAY_INDEX ){
        return [LunarDate dayDescription:row + 1];
    }
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component == LUNAR_YEAR_INDEX ){
        [self reloadComponent:LUNAR_MONTH_INDEX];
        [self reloadComponent:LUNAR_DAY_INDEX];
    }else if(component == LUNAR_MONTH_INDEX ){
        [self reloadComponent:LUNAR_DAY_INDEX];
    }else if(component == LUNAR_DAY_INDEX ){         
    }

    _lunarDate = [LunarDate lunarDateWithLunarYear:[self lunarYear] lunarMonth:[self lunarMonth] andLunarDay:[self lunarDay]];
    [self.datePickerViewDelegate lunarDatePickerDidChange:self];
}



 

@end
