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
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self getDefaults];
    
    self.BLUE = [UIColor colorWithRed:(0) green:(122/255.0) blue:(1) alpha:1];
    self.GRAY = [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(147/255.0) alpha:1];
    self.RED = [UIColor colorWithRed:(1) green:(59/255.0) blue:(48/255.0) alpha:1];
    self.BLACK = [UIColor colorWithRed:(0) green:(0) blue:(0) alpha:1];
    self.LIGHTBLUE = [UIColor colorWithRed:(90/255) green:(200/255) blue:(250/255) alpha:1];
    
    self.arrButtons = @[self.numButton1, self.numButton2, self.numButton3, self.numButton4, self.numButton5, self.numButton6, self.numButton7, self.numButton8, self.numButton9, self.numButton0, self.numButtonDot, self.buttonDel];
    
    [self cosmetic: self.arrButtons];
    
    self.arrPercent = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50"];
    self.arrPeople = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    
    self.percent = [NSNumber numberWithFloat:self.default_tip];
    self.people = [NSNumber numberWithInt:1];
    self.strSubTotal = @"";
    
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    
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
    
    self.default_tax = [self.userDefaults boolForKey:@"has_default_tax"] == YES ? [self.userDefaults floatForKey:@"default_tax"] : 8.875;
    self.default_tip = [self.userDefaults boolForKey:@"has_default_tip"] == YES ? [self.userDefaults floatForKey:@"default_tip"] : 15.0;
}

- (void) setDefaults
{
    [self.userDefaults setInteger:self.people.intValue forKey:@"default_people"];
    
    [self.userDefaults setBool:self.bDefaultRoundTip forKey:@"default_roundtip"];
    [self.userDefaults setBool:self.bDefaultDontRound forKey:@"default_dontround"];
    [self.userDefaults setBool:self.bDefaultRoundTotal forKey:@"default_roundtotal"];
    
    [self.userDefaults setFloat:self.default_tax forKey:@"default_tax"];
    [self.userDefaults setBool:YES forKey:@"has_default_tax"];
    
    [self.userDefaults setFloat:self.default_tip forKey:@"default_tip"];
    [self.userDefaults setBool:YES forKey:@"has_default_tip"];
    
    [self.userDefaults synchronize];
}

- (void) animate
{
    [self.switch_DontRound setOn:self.bDefaultDontRound animated:YES];
    [self.switch_RoundTotal setOn:self.bDefaultRoundTotal animated:YES];
    [self.switch_RoundTip setOn:self.bDefaultRoundTip animated:YES];
    [self.myPicker reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cosmetic: (NSArray *) arrButtons
{
    for (id button in arrButtons)
    {
        [self setSize: button];
    }
    
}

- (void) setSize: (UIButton *) ibutton
{
    //ibutton.layer.borderWidth = 1.0;
    //ibutton.layer.borderColor = self.BLACK.CGColor;
    CGRect buttonFrame = ibutton.frame;
    buttonFrame.size = CGSizeMake(64, 64);
    ibutton.frame = buttonFrame;
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
    self.total = (self.strSubTotal.floatValue + self.tip) / self.people.intValue;
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
    self.bDefaultRoundTip = self.switch_RoundTip.isOn;
    self.bDefaultDontRound = !self.bDefaultRoundTip && self.bDefaultRoundTip;
    self.bDefaultRoundTotal = !self.bDefaultRoundTip && self.bDefaultRoundTip;
    
    [self animate];
    [self updateSubTotal:-3];
}

- (IBAction)up_RoundTotal:(id)sender {
    self.bDefaultRoundTotal = self.switch_RoundTotal.isOn;
    self.bDefaultDontRound = !self.bDefaultRoundTotal && self.bDefaultRoundTotal;
    self.bDefaultRoundTip = !self.bDefaultRoundTotal && self.bDefaultRoundTotal;
    
    [self animate];
    [self updateSubTotal:-3];
}

- (IBAction)up_DontRound:(id)sender {
    self.bDefaultDontRound = TRUE;
    self.bDefaultRoundTip = FALSE;
    self.bDefaultRoundTotal = FALSE;
    
    [self setDefaults];
    [self animate];
}

@end
