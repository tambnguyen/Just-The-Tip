//
//  mySettings.m
//  Just The Tip
//
//  Created by Tam Nguyen on 5/9/15.
//  Copyright  ( c )  2015 Tam Nguyen. All rights reserved.
//

#import "mySettings.h"

@interface mySettings  (  ) 

@end

@implementation mySettings

-  ( void ) viewDidLoad {
     [ super viewDidLoad ] ;
    // Do any additional setup after loading the view.
    
    self.userDefaults =  [ NSUserDefaults standardUserDefaults ] ;
    
     [ self getDefaults ] ;
    
    self.textDefaultTax.text =  [ NSString stringWithFormat:@"%.3f", self.default_tax ] ;
    self.textDefaultTip.text =  [ NSString stringWithFormat:@"%.f", self.default_tip ] ;
    
     [ self animate ] ;
}

-  ( void ) didReceiveMemoryWarning {
     [ super didReceiveMemoryWarning ] ;
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-  ( void ) prepareForSegue: ( UIStoryboardSegue * ) segue sender: ( id ) sender {
    // Get the new view controller using  [ segue destinationViewController ] .
    // Pass the selected object to the new view controller.
}
*/

-  ( void ) getDefaults
{
    self.bDefaultRoundTip =  [ self.userDefaults boolForKey:@"default_roundtip" ] ;
    self.bDefaultDontRound =  [ self.userDefaults boolForKey:@"default_dontround" ] ;
    self.bDefaultRoundTotal =  [ self.userDefaults boolForKey:@"default_roundtotal" ] ;
    self.bRememberLastBill =  [ self.userDefaults boolForKey:@"remember_last_bill" ] ;
    
    self.default_tax =  [ self.userDefaults boolForKey:@"has_default_tax" ]  == YES ?  [ self.userDefaults floatForKey:@"default_tax" ]  : 8.875;
    self.default_tip =  [ self.userDefaults boolForKey:@"has_default_tip" ]  == YES ?  [ self.userDefaults floatForKey:@"default_tip" ]  : 15.0;
}

-  ( void ) setDefaults
{
     [ self.userDefaults setBool:self.bDefaultRoundTip forKey:@"default_roundtip" ] ;
     [ self.userDefaults setBool:self.bDefaultDontRound forKey:@"default_dontround" ] ;
     [ self.userDefaults setBool:self.bDefaultRoundTotal forKey:@"default_roundtotal" ] ;
     [ self.userDefaults setBool:self.bRememberLastBill forKey:@"remember_last_bill" ] ;
    
     [ self.userDefaults setFloat:self.default_tax forKey:@"default_tax" ] ;
     [ self.userDefaults setBool:YES forKey:@"has_default_tax" ] ;
    
     [ self.userDefaults setFloat:self.default_tip forKey:@"default_tip" ] ;
     [ self.userDefaults setBool:YES forKey:@"has_default_tip" ] ;
    
     [ self.userDefaults synchronize ] ;
}

-  ( void ) animate
{
     [ self.switchDefaultDontRound setOn:self.bDefaultDontRound animated:YES ] ;
     [ self.switchDefaultRoundTotal setOn:self.bDefaultRoundTotal animated:YES ] ;
     [ self.switchDefaultRoundTip setOn:self.bDefaultRoundTip animated:YES ] ;
     [ self.switchRememberLastBill setOn:self.bRememberLastBill animated:YES ] ;
}

-  ( IBAction ) up_default_roundtip: ( id ) sender {
    self.bDefaultRoundTip = self.switchDefaultRoundTip.isOn;
    self.bDefaultDontRound = !self.bDefaultRoundTip && self.bDefaultRoundTip;
    self.bDefaultRoundTotal = !self.bDefaultRoundTip && self.bDefaultRoundTip;

     [ self setDefaults ] ;
     [ self animate ] ;
}

-  ( IBAction ) up_default_roundtotal: ( id ) sender {
    self.bDefaultRoundTotal = self.switchDefaultRoundTotal.isOn;
    self.bDefaultDontRound = !self.bDefaultRoundTotal && self.bDefaultRoundTotal;
    self.bDefaultRoundTip = !self.bDefaultRoundTotal && self.bDefaultRoundTotal;

     [ self setDefaults ] ;
     [ self animate ] ;
}

-  ( IBAction ) up_default_dontround: ( id ) sender {
    self.bDefaultDontRound = TRUE;
    self.bDefaultRoundTip = FALSE;
    self.bDefaultRoundTotal = FALSE;
    
     [ self setDefaults ] ;
     [ self animate ] ;
}

-  ( IBAction ) up_default_remember_last_bill: ( id ) sender {
    self.bRememberLastBill = self.switchRememberLastBill.isOn;
     [ self setDefaults ] ;
}

-  ( IBAction ) up_default_tax: ( id ) sender {
    self.default_tax = self.textDefaultTax.text.floatValue;
     [ self setDefaults ] ;
}

-  ( IBAction ) up_default_tip: ( id ) sender {
    self.default_tip = self.textDefaultTip.text.floatValue;
     [ self setDefaults ] ;
}

@end
