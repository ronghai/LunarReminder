//
//  LunarReminderViewController.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-15.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarReminderViewController.h"

#import "LunarDate.h"
#import "LunarDatePickerViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface LunarReminderViewController ()<LunarDatePickerControllerDelegate,EKCalendarChooserDelegate,UITextFieldDelegate>
 
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UISwitch *repeat;
@property (weak, nonatomic) IBOutlet UITextView *memo;

@property (strong, nonatomic) LunarDate * lunarDate;
@property (strong, nonatomic) EKCalendar *calender;
@property (strong, nonatomic) EKEventStore *eventStore;
@property (weak, nonatomic) IBOutlet UILabel *lunarDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *calenderLabel;

@end

@implementation LunarReminderViewController
@synthesize eventTitle = _eventTitle;
@synthesize location = _location;
@synthesize repeat = _repeat;
@synthesize memo = _memo;
@synthesize lunarDate = _lunarDate;
@synthesize calender = _calender;
@synthesize eventStore = _eventStore;
@synthesize lunarDateLabel = _lunarDateLabel;
@synthesize calenderLabel = _calenderLabel;
 
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}  

#pragma  mark LunarDatePickerControllerDelegate
- (void) lunarDatePickerDidChange:(LunarDatePickerViewController *) controller{
    //nothing to do
   // NSLog(@"lunarDatePickerDidChange");
}
- (void) lunarDatePickerDidFinish:(LunarDatePickerViewController *) controller
{
    //
    [self setLunarDate:controller.lunarDate];
    [self.navigationController popViewControllerAnimated:TRUE];

    
}

- (void) lunarDatePickerDidCancel:(LunarDatePickerViewController *) controller
{
    //nothing need to do
}

#pragma  mark
// Called whenever the selection is changed by the user
- (void)calendarChooserSelectionDidChange:(EKCalendarChooser *)calendarChooser{
    
}
- (void)calendarChooserDidFinish:(EKCalendarChooser *)calendarChooser
{
    [self setCalender:[calendarChooser.selectedCalendars anyObject]];
    [self.navigationController popViewControllerAnimated:TRUE];

    
}
- (void)calendarChooserDidCancel:(EKCalendarChooser *)calendarChooser{
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 0){
        
        EKCalendarChooser *calendarChooser = [[EKCalendarChooser alloc] initWithSelectionStyle:EKCalendarChooserSelectionStyleSingle  displayStyle:EKCalendarChooserDisplayWritableCalendarsOnly  eventStore:self.eventStore];
        calendarChooser.showsDoneButton = YES;
        calendarChooser.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        calendarChooser.delegate = self; 
        calendarChooser.selectedCalendars = [NSSet setWithObject:self.calender]; 
        [self.navigationController pushViewController:calendarChooser animated:YES]; 
   
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show lunar date picker"]) { 
        [segue.destinationViewController setShowsDoneButton:TRUE];
        [segue.destinationViewController setDelegate:self];  
        [segue.destinationViewController setLunarDate:_lunarDate];
    } 
}
 
- (void) setLunarDate:(LunarDate *)lunarDate
{
 
    if(_lunarDate != lunarDate){
         _lunarDate = lunarDate;
        self.lunarDateLabel.text = [_lunarDate lunarDescription];
    }
    
 
}
- (void) setCalender:(EKCalendar *)calender
{
    
    if(_calender != calender){
         _calender = calender;
        self.calenderLabel.text = calender.title;
    }
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventStore = [[EKEventStore alloc] init]; 
    self.calender = [self.eventStore defaultCalendarForNewEvents];
	self.lunarDate = [LunarDate today];
    [self.eventTitle becomeFirstResponder];
    self.location.delegate = self;
    self.eventTitle.delegate = self;
    
   // self.navigationItem.rightBarButtonItem 
   // self.eventTitle.
   // [self.location becomeFirstResponder];
    //.nextResponder = self.location;
    //[self.eventTitle set
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
    [self setLunarDate:nil];
    [self setCalender:nil];
    [self setEventStore:nil];
    [self setLunarDateLabel:nil];
    [self setCalenderLabel:nil];
    [super viewDidUnload];
    
    //NSLog(@"test");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)changeEventTitle:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}

- (IBAction)addEvent:(id)sender {
    //TEST
    /*
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.hidesWhenStopped = TRUE;
    [self.view addSubview:spinner]; 
     
    [spinner startAnimating];
    */
    
    NSInteger lastYear = MAX_LUNAR_YEAR;
    if(self.repeat.state != UIControlStateSelected){
        lastYear = self.lunarDate.lunarYear;
    }
    
    NSError *err;
    for(int lunarYear = self.lunarDate.lunarYear ;lunarYear <= lastYear  ;lunarYear++){
        NSMutableString * string = [NSMutableString stringWithCapacity:20];          
        [string appendString:self.memo.text];
        
        int lunarMonth = self.lunarDate.lunarMonth;
        if( lunarMonth > 12 && (lunarMonth - 12) != [LunarDate lunarLeapMonth:lunarYear]){
            lunarMonth -=  12;
            [string appendString:@""];
        }
        int lunarDay = self.lunarDate.lunarDay;
        if(lunarDay == 30 && lunarDay != [LunarDate lunarMonthDaysWith:lunarYear month:lunarMonth] ){
            lunarDay = 29;
            [string appendString:@""];
        }
        
        EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
        event.allDay = TRUE;
        event.title = self.eventTitle.text;
        event.location = self.location.text;
        event.calendar = self.calender;
        
        LunarDate *ld = [LunarDate lunarDateWithLunarYear:lunarYear lunarMonth:lunarMonth andLunarDay:lunarDay];        
        NSDate * date = [[self class] dateWithYear:ld.solarYear month:ld.solarMonth day:ld.solarDay];
        event.startDate = date;
        event.endDate = date;
        
        [string appendFormat:@" \n%@",[ld lunarDescription]];
        event.notes = string ; //TODO notes

        
        [self.eventStore saveEvent:event span:EKSpanThisEvent error:&err];  
        
    } 
    [self.eventStore commit:&err];
   // [spinner stopAnimating];
 }


-(BOOL)textFieldShouldReturn:(UITextField *)sender {
    if( sender == self.eventTitle){
        [self.location becomeFirstResponder];
    }else  if( sender == self.location){
        [sender resignFirstResponder];
    } 
    return YES;

}
 
 
 

@end
