//
//  LunarEventsTableViewController.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-25.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarEventsTableViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "LunarDate.h"
#import "LunarReminderViewController.h"
#define FAVORITES_KEY @"LunarEventsTableViewController.Favorites"


@interface LunarEventsTableViewController ()<LunarReminderLunarReminderViewControllerDelegate>

@property (strong, nonatomic) EKEventStore *eventStore;
@end

@implementation LunarEventsTableViewController
@synthesize eventStore = _eventStore;
@synthesize lunarEvents = _lunarEvents;


- (void) save:(LunarReminderViewController *) controller withEvents:(NSMutableArray *)events{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults objectForKey:FAVORITES_KEY] mutableCopy];
    if (!favorites) favorites = [NSMutableArray array];
    [favorites addObject:events];
    [defaults setObject:favorites forKey:FAVORITES_KEY];
    [defaults synchronize]; 
    [self dismissModalViewControllerAnimated:TRUE]; 
    self.lunarEvents = favorites;
}

- (void) cancel:(LunarReminderViewController *) controller{
    [self dismissModalViewControllerAnimated:TRUE];
}




- (void) setLunarEvents:(NSMutableArray *)lunarEvents
{
    if(_lunarEvents != lunarEvents){
        _lunarEvents = lunarEvents;
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



- (NSMutableArray *) events
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:FAVORITES_KEY];
}

- (void) setup
{
    self.lunarEvents = [self events];
    self.eventStore = [[EKEventStore alloc] init]; 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lunarEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"event cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray *events = [self.lunarEvents objectAtIndex:indexPath.row];
    EKEvent *event = [self.eventStore eventWithIdentifier:[events objectAtIndex:0]];     
    cell.textLabel.text = event.title;
    NSString * date = [[LunarDate lunarDateWithDate: event.startDate]lunarDescription];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",date , events.count != 1?@"(每年)":@""];
        
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *events = [self.lunarEvents objectAtIndex:indexPath.row];
        NSError *err;
        NSMutableArray * lunarEvents =  [self.lunarEvents mutableCopy];
        [lunarEvents removeObjectAtIndex:indexPath.row];
        for(id e in events){
            EKEvent *event = [self.eventStore eventWithIdentifier:e]; 
            if([self.eventStore removeEvent:event span:EKSpanThisEvent error:&err]){
            }
        }
        if([self.eventStore commit:&err]){
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];         
        [defaults setObject:lunarEvents forKey:FAVORITES_KEY];
        [defaults synchronize];
        self.lunarEvents = lunarEvents;
        
    }   
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"show add event table view"]) {  
         
        LunarReminderViewController * controller = [[segue.destinationViewController viewControllers] objectAtIndex:0];
        [controller setEventStore: self.eventStore];  
        [controller setDelegate:self];
    }
    
      
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     
}

@end
