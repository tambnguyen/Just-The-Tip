//
//  mySettings.h
//  Just The Tip
//
//  Created by Tam Nguyen on 5/9/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ViewControllerDelegate.h"


@interface mySettings : UIViewController {
    //id <ViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <ViewControllerDelegate> delegate;
//@property (weak, nonatomic) id<ViewControllerDelegate> delegate;
//@property (nonatomic, assign) id delegate;
//@property (retain) id delegate;
//@property (nonatomic, assign) id delegate;

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (assign) float default_tip;
@property (assign) float default_tax;
@property (assign) BOOL has_default_tip;
@property (assign) BOOL has_default_tax;

@property (assign) BOOL bDefaultRoundTip;
@property (assign) BOOL bDefaultRoundTotal;
@property (assign) BOOL bDefaultDontRound;
@property (assign) BOOL bRememberLastBill;
@property (assign) BOOL bExcludeTax;

@property (strong, nonatomic) IBOutlet UITextField *textDefaultTax;
@property (strong, nonatomic) IBOutlet UITextField *textDefaultTip;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultRoundTip;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultRoundTotal;
@property (strong, nonatomic) IBOutlet UISwitch *switchDefaultDontRound;
@property (strong, nonatomic) IBOutlet UISwitch *switchRememberLastBill;
@property (strong, nonatomic) IBOutlet UISwitch *switchExcludeTax;

- (IBAction)up_default_tax:(id)sender;
- (IBAction)up_default_tip:(id)sender;
- (IBAction)up_default_roundtip:(id)sender;
- (IBAction)up_default_roundtotal:(id)sender;
- (IBAction)up_default_dontround:(id)sender;
- (IBAction)up_default_remember_last_bill:(id)sender;
- (IBAction)up_default_exclude_tax:(id)sender;

@end
