//
//  LunarDatePickerViewController.h
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-20.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LunarDate.h"
@class LunarDatePickerViewController;
@protocol LunarDatePickerControllerDelegate 
@required
- (void) lunarDatePickerDidChange:(LunarDatePickerViewController *) controller;
- (void) lunarDatePickerDidFinish:(LunarDatePickerViewController *) controller;

@optional
- (void) lunarDatePickerDidCancel:(LunarDatePickerViewController *) controller;

@end

@interface LunarDatePickerViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id<LunarDatePickerControllerDelegate> delegate;
@property (nonatomic, strong) LunarDate *lunarDate;
@property (nonatomic) BOOL showsDoneButton;
@property (nonatomic) BOOL showsCancelButton;

@end
