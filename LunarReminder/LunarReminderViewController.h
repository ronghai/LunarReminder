//
//  LunarReminderViewController.h
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-15.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
@class LunarReminderViewController;

@protocol LunarReminderLunarReminderViewControllerDelegate <NSObject>

- (void) save:(LunarReminderViewController *) controller withEvents:(NSMutableArray *)events;
- (void) cancel:(LunarReminderViewController *) controller;

@end

@interface LunarReminderViewController : UITableViewController


@property (nonatomic, weak) IBOutlet id<LunarReminderLunarReminderViewControllerDelegate> delegate;
@property (strong, nonatomic) EKEventStore *eventStore;

@end
