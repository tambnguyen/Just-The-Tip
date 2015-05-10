//
//  ViewController.h
//  Just The Tip
//
//  Created by Tam Nguyen on 5/7/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (nonatomic,strong) UIColor *BLUE;
@property (nonatomic,strong) UIColor *GRAY;
@property (nonatomic,strong) UIColor *RED;
@property (nonatomic,strong) UIColor *BLACK;
@property (nonatomic,strong) UIColor *LIGHTBLUE;

@property (nonatomic,strong) NSArray *arrPercent;
@property (nonatomic,strong) NSArray *arrPeople;

@property (nonatomic,strong) NSArray *arrButtons;

@property (strong, nonatomic) IBOutlet UIButton *numButton1;
@property (strong, nonatomic) IBOutlet UIButton *numButton2;
@property (strong, nonatomic) IBOutlet UIButton *numButton3;
@property (strong, nonatomic) IBOutlet UIButton *numButton4;
@property (strong, nonatomic) IBOutlet UIButton *numButton5;
@property (strong, nonatomic) IBOutlet UIButton *numButton6;
@property (strong, nonatomic) IBOutlet UIButton *numButton7;
@property (strong, nonatomic) IBOutlet UIButton *numButton8;
@property (strong, nonatomic) IBOutlet UIButton *numButton9;
@property (strong, nonatomic) IBOutlet UIButton *numButton0;
@property (strong, nonatomic) IBOutlet UIButton *numButtonDot;
@property (strong, nonatomic) IBOutlet UIButton *buttonDel;

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;

@property (strong, nonatomic) NSString *strSubTotal;

@property (strong, nonatomic) NSNumber *percent;
@property (strong, nonatomic) NSNumber *people;

@property (assign) float total;
@property (assign) float tip;
@property (assign) float subtotal;

@property (assign) BOOL bRoundTip;
@property (assign) BOOL bRoundTotal;
@property (assign) BOOL bDontRound;
@property (assign) BOOL bRememberLastBill;

@property (assign) float default_tip;
@property (assign) float default_tax;

@property (assign) BOOL bDefaultRoundTip;
@property (assign) BOOL bDefaultRoundTotal;
@property (assign) BOOL bDefaultDontRound;

- (IBAction)touchDown_b0:(id)sender;
- (IBAction)touchDown_b1:(id)sender;
- (IBAction)touchDown_b2:(id)sender;
- (IBAction)touchDown_b3:(id)sender;
- (IBAction)touchDown_b4:(id)sender;
- (IBAction)touchDown_b5:(id)sender;
- (IBAction)touchDown_b6:(id)sender;
- (IBAction)touchDown_b7:(id)sender;
- (IBAction)touchDown_b8:(id)sender;
- (IBAction)touchDown_b9:(id)sender;
- (IBAction)touchDown_dot:(id)sender;
- (IBAction)touchDown_del:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *field_SubTotal;
@property (strong, nonatomic) IBOutlet UITextField *field_Total;
@property (strong, nonatomic) IBOutlet UITextField *field_Tip;

- (IBAction)up_RoundTip:(id)sender;
- (IBAction)up_RoundTotal:(id)sender;
- (IBAction)up_DontRound:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *switch_RoundTip;
@property (strong, nonatomic) IBOutlet UISwitch *switch_RoundTotal;
@property (strong, nonatomic) IBOutlet UISwitch *switch_DontRound;

@end



