//
//  ViewController.h
//  Just The Tip
//
//  Created by Tam Nguyen on 5/7/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mySettings.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, MySettingsViewControllerDelegate> {
}

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (nonatomic,strong) NSArray *arrPercent;
@property (nonatomic,strong) NSArray *arrPeople;

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;

@property (strong, nonatomic) NSString *strSubTotal;

@property (strong, nonatomic) NSNumber *percent;
@property (strong, nonatomic) NSNumber *people;

@property (assign) float total;
@property (assign) float tip;
@property (assign) float subtotal;
@property (assign) float split_tip;
@property (assign) float split_total;

@property (assign) BOOL bRoundTip;
@property (assign) BOOL bRoundTotal;
@property (assign) BOOL bDontRound;
@property (assign) BOOL bRememberLastBill;
@property (assign) BOOL bExcludeTax;

@property (assign) float default_tip;
@property (assign) float default_tax;
@property (assign) BOOL has_default_tip;
@property (assign) BOOL has_default_tax;

@property (assign) BOOL bDefaultRoundTip;
@property (assign) BOOL bDefaultRoundTotal;
@property (assign) BOOL bDefaultDontRound;

@property (strong, nonatomic) IBOutlet UITextField *field_SubTotal;
@property (strong, nonatomic) IBOutlet UITextField *field_Total;
@property (strong, nonatomic) IBOutlet UITextField *field_Tip;

- (IBAction)up_RoundTip:(id)sender;
- (IBAction)up_RoundTotal:(id)sender;
- (IBAction)up_DontRound:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label_Tip;
@property (strong, nonatomic) IBOutlet UILabel *label_Total;

@property (strong, nonatomic) IBOutlet UISwitch *switch_RoundTip;
@property (strong, nonatomic) IBOutlet UISwitch *switch_RoundTotal;
@property (strong, nonatomic) IBOutlet UISwitch *switch_DontRound;


- (IBAction)up_field_subtotal:(id)sender;

@end



