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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self getDefaults];
    
    self.BLUE = [UIColor colorWithRed:(0) green:(122/255.0) blue:(1) alpha:1];
    self.GRAY = [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(147/255.0) alpha:1];
    self.RED = [UIColor colorWithRed:(1) green:(59/255.0) blue:(48/255.0) alpha:1];
    self.BLACK = [UIColor colorWithRed:(0) green:(0) blue:(0) alpha:1];
    self.LIGHTBLUE = [UIColor colorWithRed:(90/255) green:(200/255) blue:(250/255) alpha:1];
    self.ORANGE = [UIColor colorWithRed:(1) green:(149/255) blue:(0) alpha:1];
    
    self.arrButtons = @[self.numButton1, self.numButton2, self.numButton3, self.numButton4, self.numButton5, self.numButton6, self.numButton7, self.numButton8, self.numButton9, self.numButton0, self.numButtonDot, self.buttonDel];
    
    [self cosmetic: self.arrButtons];
    
    self.arrPercent = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50"];
    self.arrPeople = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    
    self.percent = [NSNumber numberWithFloat:self.default_tip];
    self.people = [NSNumber numberWithInt:1];
    self.strSubTotal = @"";
    
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    
    if (self.bRememberLastBill)
    {
        self.subtotal = [self.userDefaults floatForKey:@"sub_total"];
        self.strSubTotal = [NSString stringWithFormat: @"%.2f", self.subtotal];
        [self updateSubTotal:-3];
    }
    
    [self animate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.myPicker selectRow:self.percent.integerValue-1 inComponent:0 animated:YES];
    [self.myPicker selectRow:self.people.integerValue-1 inComponent:1 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animate];
}

- (void) getDefaults
{
    self.people = [NSNumber numberWithInteger:[self.userDefaults integerForKey:@"default_people"]];
    
    self.bDefaultRoundTip = [self.userDefaults boolForKey:@"default_roundtip"];
    self.bDefaultDontRound = [self.userDefaults boolForKey:@"default_dontround"];
    self.bDefaultRoundTotal = [self.userDefaults boolForKey:@"default_roundtotal"];
    self.bRememberLastBill = [self.userDefaults boolForKey:@"remember_last_bill"];
    self.subtotal = [self.userDefaults floatForKey:@"sub_total"];
    
    self.default_tax = [self.userDefaults boolForKey:@"has_default_tax"] == YES ? [self.userDefaults floatForKey:@"default_tax"] : 8.875;
    self.default_tip = [self.userDefaults boolForKey:@"has_default_tip"] == YES ? [self.userDefaults floatForKey:@"default_tip"] : 15.0;
    
    self.bRoundTip = self.bDefaultRoundTip;
    self.bRoundTotal = self.bDefaultRoundTotal;
    self.bDontRound = self.bDefaultDontRound;
}

- (void) animate
{
    [self.switch_DontRound setOn:self.bDontRound animated:YES];
    [self.switch_RoundTotal setOn:self.bRoundTotal animated:YES];
    [self.switch_RoundTip setOn:self.bRoundTip animated:YES];
    [self.myPicker reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cosmetic: (NSArray *) arrButtons
{
    
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

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    NSAttributedString *attString;
    if(component == 0)
    {
        title = [NSString stringWithFormat:@"%@%@", [self.arrPercent objectAtIndex:row], @"%"];
    }
    else
    {
        title = [self.arrPeople objectAtIndex:row];
    }
    attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: self.ORANGE}];
    return attString;
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
    NSString *strTotal = self.field_SubTotal.text.length > 0 ? [self.field_SubTotal.text stringByReplacingOccurrencesOfString:@"$ " withString:@""] : NULL;
    
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
    
    self.subtotal = self.strSubTotal.floatValue;
    [self.userDefaults setFloat:self.strSubTotal.floatValue forKey:@"sub_total"];
    [self calcTip: self.subtotal];
    [self calcTotal: self.subtotal];
}

- (void) calcTotal: (float) subtotal
{
    self.total = (self.strSubTotal.floatValue + self.tip) / self.people.intValue;
    if (self.bRoundTotal)
    {
        self.total = ceilf(self.total);
    }
    self.field_Total.text = [NSString stringWithFormat:@"$ %.2f", self.total];
}

- (void) calcTip: (float) subtotal
{
    self.tip = subtotal * self.percent.floatValue / 100.0;
    if (self.bRoundTip)
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
    self.bRoundTip = self.switch_RoundTip.isOn;
    self.bDontRound = !self.bRoundTip && self.bRoundTip;
    self.bRoundTotal = !self.bRoundTip && self.bRoundTip;
    
    [self animate];
    [self updateSubTotal:-3];
}

- (IBAction)up_RoundTotal:(id)sender {
    self.bRoundTotal = self.switch_RoundTotal.isOn;
    self.bDontRound = !self.bRoundTotal && self.bRoundTotal;
    self.bRoundTip = !self.bRoundTotal && self.bRoundTotal;
    
    [self animate];
    [self updateSubTotal:-3];
}

- (IBAction)up_DontRound:(id)sender {
    self.bDontRound = TRUE;
    self.bRoundTip = FALSE;
    self.bRoundTotal = FALSE;
    
    [self animate];
    [self updateSubTotal:-3];
}

@end
