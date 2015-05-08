//
//  ViewController.m
//  Just The Tip
//
//  Created by Tam Nguyen on 5/7/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize BLUE;
@synthesize GRAY;
@synthesize RED;
@synthesize BLACK;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.BLUE = [UIColor colorWithRed:(0) green:(122/255.0) blue:(1) alpha:1];
    self.GRAY = [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(147/255.0) alpha:1];
    self.RED = [UIColor colorWithRed:(1) green:(59/255.0) blue:(48/255.0) alpha:1];
    self.BLACK = [UIColor colorWithRed:(0) green:(0) blue:(0) alpha:1];
    [self changeColor];
    
    self.arrPercent = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50"];
    self.arrPeople = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeColor
{
    [self setBorder:self.numButton1];
    [self setBorder:self.numButton2];
    [self setBorder:self.numButton3];
    [self setBorder:self.numButton4];
    [self setBorder:self.numButton5];
    [self setBorder:self.numButton6];
    [self setBorder:self.numButton7];
    [self setBorder:self.numButton8];
    [self setBorder:self.numButton9];
    [self setBorder:self.numButton0];
    [self setBorder:self.numButtonDot];
    [self setBorder:self.buttonDel];
}

- (void) setBorder: (UIButton *) ibutton
{
    ibutton.layer.borderWidth = 1.0;
    ibutton.layer.borderColor = self.BLACK.CGColor;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if(component== 0)
    {
        return [self.arrPercent count];
    }
    else
    {
        return [self.arrPeople count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [NSString stringWithFormat:@"%@%@", [self.arrPercent objectAtIndex:row], @"%"];
    }
    else
    {
        return [self.arrPeople objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        self.percent = [self.arrPercent objectAtIndex:row];
        NSLog(self.percent);
    }
    else
    {
        self.people = [self.arrPeople objectAtIndex:row];
        NSLog(self.people);
    }
}

@end
