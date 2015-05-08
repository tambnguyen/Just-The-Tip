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
    
    NSInteger myIntegers[100];
    for (NSInteger i = 0; i < 100; i++) {
        myIntegers[i] = i+1;
        //_pickerData[i] = i+1;
    }
    
    //_pickerData = myIntegers;
    self.pickerData = [[NSArray alloc] initWithObjects: @"Blue", @"Green", @"Orange", @"Purple", @"Red", @"Yellow", nil];
    
    self.myPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeColor
{
    self.numButton1.layer.borderWidth = 1.0;
    self.numButton1.layer.borderColor = self.BLACK.CGColor;
    
    self.numButton2.layer.borderWidth = 1.0;
    self.numButton2.layer.borderColor = self.BLACK.CGColor;
    
    self.numButton3.layer.borderWidth = 1.0;
    self.numButton3.layer.borderColor = self.BLACK.CGColor;
    
    self.numButton4.layer.borderWidth = 1.0;
    self.numButton4.layer.borderColor = self.BLACK.CGColor;

    self.numButton5.layer.borderWidth = 1.0;
    self.numButton5.layer.borderColor = self.BLACK.CGColor;

    self.numButton6.layer.borderWidth = 1.0;
    self.numButton6.layer.borderColor = self.BLACK.CGColor;

    self.numButton7.layer.borderWidth = 1.0;
    self.numButton7.layer.borderColor = self.BLACK.CGColor;

    self.numButton8.layer.borderWidth = 1.0;
    self.numButton8.layer.borderColor = self.BLACK.CGColor;

    self.numButton9.layer.borderWidth = 1.0;
    self.numButton9.layer.borderColor = self.BLACK.CGColor;

    self.numButton0.layer.borderWidth = 1.0;
    self.numButton0.layer.borderColor = self.BLACK.CGColor;

    self.numButtonDot.layer.borderWidth = 1.0;
    self.numButtonDot.layer.borderColor = self.BLACK.CGColor;

    self.buttonDel.layer.borderWidth = 1.0;
    self.buttonDel.layer.borderColor = self.BLACK.CGColor;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 6;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"Selected Row %ld", (long)row);
    
}

@end
