//
//  LunarDatePickerViewController.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-20.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarDatePickerViewController.h"
#import "LunarDatePicker.h"
#import "LunarDate.h"
@interface LunarDatePickerViewController () <LunarDatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet LunarDatePicker *lunarDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
 
@end

@implementation LunarDatePickerViewController
@synthesize lunarDatePicker = _lunarDatePicker;
@synthesize cellLabel = _cellLabel;
@synthesize delegate = _delegate;
@synthesize lunarDate = _lunarDate;
@synthesize showsDoneButton = _showsDoneButton;
@synthesize showsCancelButton = _showsCancelButton;

 
#pragma mark LunarDatePickerViewDelegate
- (void) lunarDatePickerDidChange:(LunarDatePicker *)sender
{
    [self setLunarDate:sender.lunarDate];
    [self.delegate lunarDatePickerDidChange:self];
}

- (void) setLunarDate:(LunarDate *)lunarDate
{
    if(lunarDate != _lunarDate){ 
        _lunarDate = lunarDate;
        self.cellLabel.text = [lunarDate lunarDescription];
    }
}

#

- (void) done
{ 	
    [self.delegate lunarDatePickerDidFinish:self];
}

- (void) cancel
{ 	
    [self.delegate lunarDatePickerDidCancel:self];
}



#pragma mark setup

- (void) setup
{
    self.cellLabel.text = [_lunarDate lunarDescription]; 
    self.lunarDatePicker.datePickerViewDelegate = self; 
    self.lunarDatePicker.lunarDate = _lunarDate;

    
 	if(_showsDoneButton){
		UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  
                                                                                     target:self  
                                                                                     action:@selector(done) ];
		doneButton.style = UIBarButtonItemStyleDone;
        self.navigationItem.rightBarButtonItem = doneButton;
	
    }
	
	if(_showsCancelButton){
		UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                       target:self  
                                                                                       action:@selector(cancel) ];
		cancelButton.style = UIBarButtonItemStyleDone; 
        self.navigationItem.leftBarButtonItem = cancelButton;
	} 
	

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad]; 
    [self setup];

}

- (void)viewDidUnload
{
    [self setCellLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 

@end
