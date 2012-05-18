//
//  LunarReminderViewController.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-15.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarReminderViewController.h"

@interface LunarReminderViewController ()
 
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UISwitch *repeat;
@property (weak, nonatomic) IBOutlet UITextView *memo;

@end

@implementation LunarReminderViewController
@synthesize eventTitle = _eventTitle;
@synthesize location = _location;
@synthesize repeat = _repeat;
@synthesize memo = _memo;
 

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show lunar date picker"]) {
        //[segue.destinationViewController setHappiness:self.diagnosis];
    } else if ([segue.identifier isEqualToString:@"show calendar"]) {
       // [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
     //   [segue.destinationViewController setHappiness:100];
    }
}

- (void) setup
{
    //_memo.
   // _repeat.
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
 
    [self setEventTitle:nil];
    [self setLocation:nil];
    [self setRepeat:nil];
    [self setMemo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addEvent:(id)sender {
}

@end
