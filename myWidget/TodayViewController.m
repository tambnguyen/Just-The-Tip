//
//  TodayViewController.m
//  myWidget
//
//  Created by Tam Nguyen on 5/11/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.userDefaults =  [[NSUserDefaults alloc] initWithSuiteName:@"group.Just-The-Tip"] ;
    [ self getDefaults ] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

-  ( void ) getDefaults
{
    self.bRoundTip =  [ self.userDefaults boolForKey:@"default_roundtip" ] ;
    self.bDontRound =  [ self.userDefaults boolForKey:@"default_dontround" ] ;
    self.bRoundTotal =  [ self.userDefaults boolForKey:@"default_roundtotal" ] ;
    
    self.has_default_tip = [ self.userDefaults boolForKey:@"has_default_tip" ] ;
    
    self.default_tip =  self.has_default_tip ? [ self.userDefaults floatForKey:@"default_tip" ] : 15.0;
    
    self.percent = self.default_tip;
    
    self.strSubTotal = @"";
}
/*
-  ( void ) viewWillAppear: ( BOOL ) animated
{
    [ super viewWillAppear:animated ] ;
    self.label_subtotal.text = @"$ ";
}
*/
-  ( void )  updateSubTotal:  ( float )  value
{
    NSString * strTotal = self.label_subtotal.text.length > 0 ?  [ self.label_subtotal.text stringByReplacingOccurrencesOfString:@"$ " withString:@"" ] : NULL;
    
    if  ( value == -1 )  {  // dot
        if  ( strTotal.length > 0 )  { self.strSubTotal =  [ NSString stringWithFormat:@"%@%@", strTotal, @"." ] ; }
    }
    else if  ( value == -2 )  { // del
        if  ( strTotal.length > 0 )  { self.strSubTotal =  [ strTotal substringToIndex: [ strTotal length ] -1 ] ; }
    }
    else if  ( value == -3 )  {
        NSLog ( @"No op!" ) ;
    }
    else {
        if  ( strTotal.length == 0 && value != 0 )  {
            self.strSubTotal =  [ NSString stringWithFormat:@"%d",  ( int ) value ] ;
        }
        else if  ( strTotal.length == 0 && value == 0 )  {
            self.strSubTotal = @"";
        }
        else {
            self.strSubTotal =  [ NSString stringWithFormat:@"%@%d", strTotal,  ( int ) value ] ;
        }
    }
    
    self.label_subtotal.text = [ NSString stringWithFormat:@"$ %@", self.strSubTotal ] ;
    
    self.subtotal = self.strSubTotal.floatValue;

    [ self calcTip: self.subtotal ] ;
    [ self calcTotal: self.subtotal ] ;
    [ self updateFields ] ;
}

// - (void)methodName:(NSString *)parameterOne methodNameContinues:(NSString *)parameterTwo;
- ( void ) validateWithOldString : ( NSString * ) oldString withNewChar : ( NSString * ) newChar
{
    NSString * newString = [ NSString stringWithFormat:@"%@%@", [ oldString stringByReplacingOccurrencesOfString:@"$ " withString:@"" ], newChar ];
    NSString * pattern1 = @"(\\d*[.])?\\d+";
    NSString * pattern2 = @"\\d*[.]";
    NSPredicate * myTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern1];
    NSPredicate * myTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern2];
    
    if ( [ myTest1 evaluateWithObject: newString ] || [ myTest2 evaluateWithObject: newString ] || [ newString length ] == 0 )
    {
        self.strSubTotal = newString;
    }
    else
    {
        self.label_subtotal.text = [ NSString stringWithFormat:@"%@", self.strSubTotal ] ;
    }
}

-  ( void )  calcTotal: ( float ) subtotal
{
    self.total =  ( self.subtotal + self.tip );
    if  ( self.bRoundTotal )
    {
        self.total = ceilf ( self.total ) ;
        self.tip = self.total - ( self.subtotal ) ;
    }
}

-  ( void )  calcTip: ( float ) subtotal
{
    self.tip = subtotal * self.percent / 100.0;
    if  ( self.bRoundTip )
    {
        self.tip =  ( float ) ceilf ( self.tip ) ;
    }
}

- ( void ) updateFields
{
    self.label_tip.text =  [ NSString stringWithFormat:@"$ %.2f", self.tip ] ;
    self.label_total.text = [ NSString stringWithFormat:@"$ %.2f", self.total ] ;
}

-  ( IBAction ) touchDown_b0: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"0" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b1: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"1" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b2: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"2" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b3: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"3" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b4: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"4" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b5: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"5" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b6: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"6" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b7: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"7" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b8: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"8" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_b9: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"9" ];
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) touchDown_dot: ( id ) sender {
    [ self validateWithOldString:self.strSubTotal withNewChar: @"." ];
    [ self updateSubTotal:-3 ] ;
}

- (IBAction)touchDown_back:(id)sender {
    [ self updateSubTotal:-2 ] ;
}
@end
