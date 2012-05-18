//
//  LunarDatePickerViewController.m
//  LunarReminder
//
//  Created by 韦 荣海 on 12-5-17.
//  Copyright (c) 2012年 ronghai.me. All rights reserved.
//

#import "LunarDatePickerViewController.h"

@interface LunarDatePickerViewController()<UIPickerViewDelegate, UIPickerViewDataSource> 
@property (weak, nonatomic) IBOutlet UIPickerView *datePicker;

@end

@implementation LunarDatePickerViewController

@synthesize datePicker = _datePicker;

#pragma mark UIPickerViewDataSource
// returns the number of 'columns' to display. 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 4;
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return  [NSString stringWithFormat:@"%d : %d", row,component ];
}


#pragma mark view cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
        // Custom initialization
    }
    return self;
}

- (void)setup
{
   //self.view set
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
