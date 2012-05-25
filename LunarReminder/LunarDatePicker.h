//
//  LunarDatePicker.h
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-18.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LunarDate;
@class LunarDatePicker;
@protocol LunarDatePickerViewDelegate <NSObject> 
- (void) lunarDatePickerDidChange:(LunarDatePicker *)sender;  
@end

@interface LunarDatePicker : UIPickerView
@property (nonatomic, assign) IBOutlet id <LunarDatePickerViewDelegate> datePickerViewDelegate; 
@property (nonatomic, copy) LunarDate * lunarDate;
@end
