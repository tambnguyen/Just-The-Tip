//
//  ViewController.m
//  Just The Tip
//
//  Created by Tam Nguyen on 5/7/15.
//  Copyright  ( c )  2015 Tam Nguyen. All rights reserved.
//
//  Color scheme: https://color.adobe.com/1944mustang-color-theme-4817/

#import "ViewController.h"
#import "mySettings.h"

@interface ViewController  (  ) 
@property (nonatomic, strong) mySettings *settingsVC;
@end

@implementation ViewController

-  ( void ) viewDidLoad {
    [ super viewDidLoad ] ;
    // Do any additional setup after loading the view, typically from a nib.
    
    self.userDefaults =  [[NSUserDefaults alloc] initWithSuiteName:@"group.Just-The-Tip"] ;
    [ self getDefaults ] ;
    
    self.arrPercent = @ [ @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50" ] ;
    self.arrPeople = @ [ @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20" ] ;
    
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    
    if ( self.bRememberLastBill )
    {
        self.subtotal =  [ self.userDefaults floatForKey:@"sub_total" ] ;
        self.strSubTotal =  [ NSString stringWithFormat: @"%.2f", self.subtotal ] ;
        [ self updateSubTotal:-3 ] ;
    }
    
    // BEGIN ENABLE DONE BUTTON FOR NUMPAD
    UIToolbar * keyboardDoneButtonView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 32)];;
    keyboardDoneButtonView.items = [NSArray arrayWithObjects:
                                    [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearClicked:)],
                                    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                    [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)], nil
                                    ];
    [keyboardDoneButtonView sizeToFit];
    self.field_SubTotal.inputAccessoryView = keyboardDoneButtonView;
    // END ENABLE DONE BUTTON FOR NUMPAD
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 60)];
    self.field_SubTotal.rightView = paddingView;
    self.field_SubTotal.rightViewMode = UITextFieldViewModeAlways;
    
    [ self.field_SubTotal becomeFirstResponder ];
    
    self.settingsVC = [[mySettings alloc] init];
    self.settingsVC.delegate = self ;

    [ self animate ] ;
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueRegistrationUserAction"]) {
        [(mySettings *)segue.destinationViewController setDelegate:self];
    }
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.settingsVC = (mySettings *)segue.destinationViewController;
    self.settingsVC.delegate = self;
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)clearClicked:(id)sender
{
    self.strSubTotal = @"";
    self.field_SubTotal.text = @"";
    [ self updateSubTotal:-3 ];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ self.view endEditing:YES ] ;
    [ self.field_SubTotal resignFirstResponder ] ;
}

-  ( void ) viewWillAppear: ( BOOL ) animated
{
    [ super viewWillAppear:animated ] ;
    [ self.myPicker selectRow:self.people.integerValue-1 inComponent:0 animated:YES ] ;
    [ self.myPicker selectRow:self.percent.integerValue-1 inComponent:1 animated:YES ] ;
    [ self animate ] ;
}

-  ( void ) getDefaults
{
    self.people = [ NSNumber numberWithInteger: [ self.userDefaults integerForKey:@"default_people" ] ? [ self.userDefaults integerForKey:@"default_people" ] : 1 ] ;
    
    self.bDefaultRoundTip = [ self.userDefaults boolForKey:@"default_roundtip" ] ;
    self.bDefaultDontRound = [ self.userDefaults boolForKey:@"default_dontround" ] ;
    self.bDefaultRoundTotal = [ self.userDefaults boolForKey:@"default_roundtotal" ] ;
    self.bRememberLastBill = [ self.userDefaults boolForKey:@"remember_last_bill" ] ;
    self.bExcludeTax = [ self.userDefaults boolForKey:@"exclude_tax" ] ;
    
    self.subtotal = [ self.userDefaults floatForKey:@"sub_total" ] ;
    
    self.has_default_tax = [ self.userDefaults boolForKey:@"has_default_tax" ] ;
    self.has_default_tip = [ self.userDefaults boolForKey:@"has_default_tip" ] ;
    
    self.default_tax = self.has_default_tax ? [ self.userDefaults floatForKey:@"default_tax" ] : 8.875;
    self.default_tip = self.has_default_tip ? [ self.userDefaults floatForKey:@"default_tip" ] : 15.0;
    
    self.bRoundTip = self.bDefaultRoundTip;
    self.bRoundTotal = self.bDefaultRoundTotal;
    self.bDontRound = self.bDefaultDontRound;
    
    self.percent = [ NSNumber numberWithFloat:self.default_tip ] ;
    self.tip = self.default_tip;
    
    self.strSubTotal = @"";
}

-  ( void ) animate
{
    [ self.switch_DontRound setOn:self.bDontRound animated:YES ] ;
    [ self.switch_RoundTotal setOn:self.bRoundTotal animated:YES ] ;
    [ self.switch_RoundTip setOn:self.bRoundTip animated:YES ] ;
    [ self.myPicker reloadAllComponents ] ;
}

-  ( void ) didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ] ;
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
-  ( NSInteger ) numberOfComponentsInPickerView: ( UIPickerView * ) pickerView
{
    return 2;
}

// returns the # of rows in each component..
-  ( NSInteger ) pickerView: ( UIPickerView * ) pickerView numberOfRowsInComponent:  ( NSInteger ) component
{
    if ( component == 1 )
    {
         return  [ self.arrPercent count ] ;
    }
    else
    {
        return  [ self.arrPeople count ] ;
    }
}

- ( NSAttributedString * ) pickerView: ( UIPickerView * ) pickerView attributedTitleForRow: ( NSInteger ) row forComponent: ( NSInteger ) component
{
    NSString *title;
    NSAttributedString *attString;
    if ( component == 0 )
    {
        title = [ self.arrPeople objectAtIndex:row ] ;
    }
    else
    {
        title = [ NSString stringWithFormat:@"%@%@",  [ self.arrPercent objectAtIndex:row ] , @"%" ] ;
    }
    attString = [ [ NSAttributedString alloc ] initWithString:title attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} ] ;
    return attString;
}

-  ( void ) pickerView: ( UIPickerView * ) pickerView didSelectRow: ( NSInteger ) row inComponent: ( NSInteger ) component
{
    if ( component == 0 )
    {
        self.people = [ self.arrPeople objectAtIndex:row ] ;
    }
    else
    {
        self.percent = [ self.arrPercent objectAtIndex:row ] ;
    }
    [ self updateSubTotal:-3 ] ;
}

-  ( void ) updateSubTotal: ( float ) value
{
    //NSString * strTotal = self.field_SubTotal.text.length > 0 ?  [ self.field_SubTotal.text stringByReplacingOccurrencesOfString:@"$ " withString:@"" ]  : NULL;
    NSString * strTotal = self.strSubTotal;
    
    if ( value == -1 ) {  // dot
        if  ( strTotal.length > 0 )  { self.strSubTotal =  [ NSString stringWithFormat:@"%@%@", strTotal, @"." ] ; }
    }
    else if ( value == -2 ) { // del
        if ( strTotal.length > 0 )  { self.strSubTotal =  [ strTotal substringToIndex: [ strTotal length ] -1 ] ; }
    }
    else if ( value == -3 ) {
        NSLog ( @"No op!" ) ;
    }
    else {
        if ( strTotal.length == 0 && value != 0 ) {
            self.strSubTotal =  [ NSString stringWithFormat:@"%d",  ( int ) value ] ;
        }
        else if  ( strTotal.length == 0 && value == 0 ) {
            self.strSubTotal = @"";
        }
        else {
            self.strSubTotal =  [ NSString stringWithFormat:@"%@%d", strTotal,  ( int ) value ] ;
        }
    }
    self.field_SubTotal.text = [ NSString stringWithFormat:@"$ %@", self.strSubTotal ] ;
    
    self.subtotal = self.strSubTotal.floatValue;
    [ self.userDefaults setFloat:self.strSubTotal.floatValue forKey:@"sub_total" ] ;
    [ self calcTip: self.subtotal ] ;
    [ self calcTotal: self.subtotal ] ;
    [ self updateFields ] ;
}

- ( void ) calcTip: ( float ) subtotal
{
    if ( self.bExcludeTax ) {
        self.tip = ( subtotal / ( ( 100.0 + self.default_tax ) / 100.0 ) ) * self.percent.floatValue / 100.0;
    }
    else {
        self.tip = subtotal * self.percent.floatValue / 100.0;
    }
    
    self.split_tip = self.tip / self.people.intValue;
    if  ( self.bRoundTip ) 
    {
        self.tip =  ( float ) ceilf ( self.tip ) ;
        self.split_tip = (float) ceilf ( self.split_tip );
    }
}

- ( void ) calcTotal: ( float ) subtotal
{
    self.total =  ( self.subtotal + self.tip );
    self.split_total = self.total / self.people.intValue;
    if  ( self.bRoundTotal )
    {
        self.total = ( float ) ceilf ( self.total ) ;
        self.tip = self.total - ( self.subtotal ) ;
        
        self.split_total = ( float ) ceilf ( self.split_total );
        self.split_tip = self.split_total - ( self.subtotal / self.people.intValue );
    }
}

- ( void ) updateFields
{
    self.field_Tip.text =  [ NSString stringWithFormat:@"$ %.2f", self.split_tip ] ;
    self.field_Total.text = [ NSString stringWithFormat:@"$ %.2f", self.split_total ] ;
    if ( self.people.intValue > 1 )
    {
        self.label_Tip.text = [NSString stringWithFormat:@"Total tip: $%.2f", self.tip ];
        self.label_Total.text = [NSString stringWithFormat:@"Total: $%.2f", self.total ];
    }
    else
    {
        self.label_Tip.text = @"Tip";
        self.label_Total.text = @"Total";
    }
}

-  ( IBAction ) up_RoundTip: ( id ) sender {
    self.bRoundTip = self.switch_RoundTip.isOn;
    self.bDontRound = FALSE;
    self.bRoundTotal = FALSE;
    
    [ self animate ] ;
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) up_RoundTotal: ( id ) sender {
    self.bRoundTotal = self.switch_RoundTotal.isOn;
    self.bDontRound = FALSE;
    self.bRoundTip = FALSE;
    
    [ self animate ] ;
    [ self updateSubTotal:-3 ] ;
}

-  ( IBAction ) up_DontRound: ( id ) sender {
    self.bDontRound = self.switch_DontRound.isOn;
    self.bRoundTip = FALSE;
    self.bRoundTotal = FALSE;
    
    [ self animate ] ;
    [ self updateSubTotal:-3 ] ;
}

- (IBAction)up_field_subtotal:(id)sender {
    NSString * subtotal = [ self.field_SubTotal.text stringByReplacingOccurrencesOfString:@".." withString:@"." ] ;
    subtotal = [ subtotal stringByReplacingOccurrencesOfString:@"$" withString:@"" ];
    subtotal = [ subtotal stringByReplacingOccurrencesOfString:@" " withString:@"" ];
    if ( subtotal.length == 2 && [ subtotal isEqualToString:@"00" ] )
    {
        subtotal = [ NSString stringWithFormat:@"0" ];
    }
    NSString * pattern1 = @"(\\d*[.])?\\d+";
    NSString * pattern2 = @"\\d*[.]";
    NSPredicate * myTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern1];
    NSPredicate * myTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern2];
    
    if ( [ myTest1 evaluateWithObject: subtotal ] || [ myTest2 evaluateWithObject: subtotal ] || [ subtotal length ] == 0 )
    {
        self.strSubTotal = subtotal;
    }
    else
    {
        self.field_SubTotal.text = self.strSubTotal;
    }
    
    [ self updateSubTotal:-3 ] ;
}
@end
