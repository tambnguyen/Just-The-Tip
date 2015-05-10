//
//  mySettings.h
//  Just The Tip
//
//  Created by Tam Nguyen on 5/9/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface mySettings : UIViewController

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (nonatomic,strong) ViewController *calc;

@property (assign) float default_tip;
@property (assign) float default_tax;

@property (assign) BOOL bDefaultRoundTip;
@property (assign) BOOL bDefaultRoundTotal;
@property (assign) BOOL bDefaultDontRound;

@property (strong, nonatomic) IBOutlet UITextField *textDefaultTax;
@property (strong, nonatomic) IBOutlet UITextField *textDefaultTip;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultRoundTip;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultRoundTotal;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultDontRound;

- (IBAction)up_default_tax:(id)sender;
- (IBAction)up_default_tip:(id)sender;
- (IBAction)up_default_roundtip:(id)sender;
- (IBAction)up_default_roundtotal:(id)sender;
- (IBAction)up_default_dontround:(id)sender;


@end
