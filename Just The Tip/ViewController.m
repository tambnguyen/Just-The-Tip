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
    
    self.percent = [NSNumber numberWithInt:15];
    self.people = [NSNumber numberWithInt:5];
    self.strSubTotal = @"";
    
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.myPicker selectRow:self.percent.integerValue inComponent:0 animated:YES];
    //[self.myPicker selectRow:5 inComponent:0 animated:YES];
    [self.myPicker selectRow:5 inComponent:1 animated:YES];
    //[self.myPicker reloadAllComponents];

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
    }
    else
    {
        self.people = [self.arrPeople objectAtIndex:row];
    }
    [self updateSubTotal:-3];
}

- (void) updateSubTotal: (float) value
{
    NSString *strTotal = self.field_SubTotal.text.length > 0 ? [self.field_SubTotal.text stringByReplacingOccurrencesOfString:@"$ " withString:@""] : @"";
    
    if (value == -1) {  // dot
        if (strTotal.length > 0) { self.strSubTotal = [NSString stringWithFormat:@"%@%@", strTotal, @"."]; }
    }
    else if (value == -2) { // del
        if (strTotal.length > 0) { self.strSubTotal = [strTotal substringToIndex:[strTotal length]-1]; }
    }
    else if (value == -3) {
        NSLog(@"No op!");
    }
    else {
        if (strTotal.length == 0 && value != 0) {
            self.strSubTotal = [NSString stringWithFormat:@"%d", (int)value];
        }
        else if (strTotal.length == 0 && value == 0) {
            self.strSubTotal = @"";
        }
        else {
            self.strSubTotal = [NSString stringWithFormat:@"%@%d", strTotal, (int)value];
        }
    }
    self.field_SubTotal.text = [NSString stringWithFormat:@"$ %@", self.strSubTotal];
    
    [self calcTip: self.strSubTotal.floatValue];
    [self calcTotal: self.strSubTotal.floatValue];
}

- (void) calcTotal: (float) subtotal
{
    self.total = self.strSubTotal.floatValue + self.tip;
    if (self.switch_RoundTotal.isOn)
    {
        self.total = ceilf(self.total);
    }
    self.field_Total.text = [NSString stringWithFormat:@"$ %.2f", self.total];
}

- (void) calcTip: (float) subtotal
{
    self.tip = subtotal * self.percent.floatValue / 100.0;
    if ([self.switch_RoundTip isOn])
    {
        self.tip = (float)ceilf(self.tip);
    }
    self.field_Tip.text = [NSString stringWithFormat:@"$ %.2f", self.tip];
}

- (IBAction)touchDown_b0:(id)sender {
    [self updateSubTotal:0.0];
}

- (IBAction)touchDown_b1:(id)sender {
    [self updateSubTotal:1.0];
}

- (IBAction)touchDown_b2:(id)sender {
    [self updateSubTotal:2.0];
}

- (IBAction)touchDown_b3:(id)sender {
    [self updateSubTotal:3.0];
}

- (IBAction)touchDown_b4:(id)sender {
    [self updateSubTotal:4.0];
}

- (IBAction)touchDown_b5:(id)sender {
    [self updateSubTotal:5.0];
}

- (IBAction)touchDown_b6:(id)sender {
    [self updateSubTotal:6.0];
}

- (IBAction)touchDown_b7:(id)sender {
    [self updateSubTotal:7.0];
}

- (IBAction)touchDown_b8:(id)sender {
    [self updateSubTotal:8.0];
}

- (IBAction)touchDown_b9:(id)sender {
    [self updateSubTotal:9.0];
}

- (IBAction)touchDown_dot:(id)sender {
    [self updateSubTotal:-1];
}

- (IBAction)touchDown_del:(id)sender {
    [self updateSubTotal:-2];
}

- (IBAction)up_RoundTip:(id)sender {
    if (self.switch_RoundTip.isOn)
    {
        self.bRoundTip = TRUE;
        [self.switch_DontRound setOn:FALSE animated:YES];
        [self.switch_RoundTotal setOn:FALSE animated:YES];
        self.bDontRound = FALSE;
        self.bRoundTotal = FALSE;
    }
    else
    {
        self.bRoundTip = FALSE;
    }
    [self updateSubTotal:-3];
}

- (IBAction)up_RoundTotal:(id)sender {
    if (self.switch_RoundTotal.isOn)
    {
        self.bRoundTotal = TRUE;
        [self.switch_DontRound setOn:FALSE animated:YES];
        [self.switch_RoundTip setOn:FALSE animated:YES];
        self.bDontRound = FALSE;
        self.bRoundTip = FALSE;
    }
    else
    {
        self.bRoundTotal = FALSE;
    }
    [self updateSubTotal:-3];
}

- (IBAction)up_DontRound:(id)sender {
    self.bDontRound = TRUE;
    [self.switch_DontRound setOn:TRUE animated:YES];
    
    [self.switch_RoundTip setOn:FALSE animated:YES];
    self.bRoundTip = FALSE;
    
    [self.switch_RoundTotal setOn:FALSE animated:YES];
    self.bRoundTotal = FALSE;

    [self updateSubTotal:-3];
}


@end
