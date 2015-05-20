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
    
    //self.userDefaults =  [ NSUserDefaults standardUserDefaults ] ;
    self.userDefaults =  [[NSUserDefaults alloc] initWithSuiteName:@"group.Just-The-Tip"] ;
    
    [ self getDefaults ] ;
    
    self.textDefaultTax.text =  [ NSString stringWithFormat:@"%.3f", self.default_tax ] ;
    self.textDefaultTip.text =  [ NSString stringWithFormat:@"%.f", self.default_tip ] ;
    
    // BEGIN ENABLE DONE BUTTON FOR NUMPAD
    UIToolbar * keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:
                                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                      [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)],
                                      nil]];
    [keyboardDoneButtonView sizeToFit];
    self.textDefaultTip.inputAccessoryView = keyboardDoneButtonView;
    self.textDefaultTax.inputAccessoryView = keyboardDoneButtonView;
    // END ENABLE DONE BUTTON FOR NUMPAD
    
    [ self animate ] ;
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

-  ( void ) didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ] ;
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    
    self.has_default_tax = [ self.userDefaults boolForKey:@"has_default_tax" ] ;
    self.has_default_tip = [ self.userDefaults boolForKey:@"has_default_tip" ] ;
    
    self.default_tax =  self.has_default_tax ? [ self.userDefaults floatForKey:@"default_tax" ] : 8.875;
    self.default_tip =  self.has_default_tip ? [ self.userDefaults floatForKey:@"default_tip" ] : 15.0;
}

-  ( void ) setDefaults
{
     [ self.userDefaults setBool:self.bDefaultRoundTip forKey:@"default_roundtip" ] ;
     [ self.userDefaults setBool:self.bDefaultDontRound forKey:@"default_dontround" ] ;
     [ self.userDefaults setBool:self.bDefaultRoundTotal forKey:@"default_roundtotal" ] ;
     [ self.userDefaults setBool:self.bRememberLastBill forKey:@"remember_last_bill" ] ;
    
     [ self.userDefaults setFloat:self.default_tax forKey:@"default_tax" ] ;
     [ self.userDefaults setBool:self.has_default_tax forKey:@"has_default_tax" ] ;
    
     [ self.userDefaults setFloat:self.default_tip forKey:@"default_tip" ] ;
     [ self.userDefaults setBool:self.has_default_tip forKey:@"has_default_tip" ] ;
    
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
    self.bDefaultDontRound = FALSE;
    self.bDefaultRoundTotal = FALSE;

    [ self setDefaults ] ;
    [ self animate ] ;
}

-  ( IBAction ) up_default_roundtotal: ( id ) sender {
    self.bDefaultRoundTotal = self.switchDefaultRoundTotal.isOn;
    self.bDefaultDontRound = FALSE;
    self.bDefaultRoundTip = FALSE;

    [ self setDefaults ] ;
    [ self animate ] ;
}

-  ( IBAction ) up_default_dontround: ( id ) sender {
    self.bDefaultDontRound = self.switchDefaultRoundTotal.isOn;
    self.bDefaultRoundTip = FALSE;
    self.bDefaultRoundTotal = !self.switchDefaultRoundTotal.isOn;
    
    [ self setDefaults ] ;
    [ self animate ] ;
}

-  ( IBAction ) up_default_remember_last_bill: ( id ) sender {
    self.bRememberLastBill = self.switchRememberLastBill.isOn;
    [ self setDefaults ] ;
}

-  ( IBAction ) up_default_tax: ( id ) sender {
    NSString * tax = [ self.textDefaultTax.text stringByReplacingOccurrencesOfString:@".." withString:@"." ] ;
    NSString * pattern1 = @"(\\d*[.])?\\d+";
    NSString * pattern2 = @"\\d*[.]";
    NSPredicate * myTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern1];
    NSPredicate * myTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern2];
    
    if ( [ myTest1 evaluateWithObject: tax ] || [ myTest2 evaluateWithObject: tax ] || [ tax length ] == 0 )
    {
        self.default_tax = tax.floatValue;
    }
    else
    {
        self.textDefaultTax.text = [ NSString stringWithFormat:@"%.3f", self.default_tax ] ;
    }
    
    if ( tax.length == 0 )
    {
        self.has_default_tax = FALSE;
    }
    else
    {
        self.has_default_tax = TRUE;
    }
    [ self setDefaults ] ;
}

-  ( IBAction ) up_default_tip: ( id ) sender {
    self.default_tip = self.textDefaultTip.text.floatValue;
    if ( self.textDefaultTip.text.length == 0 )
    {
        self.has_default_tip = FALSE;
    }
    else
    {
        self.has_default_tip = TRUE;
    }
    [ self setDefaults ] ;
}

@end
