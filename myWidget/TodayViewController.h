//
//  TodayViewController.h
//  myWidget
//
//  Created by Tam Nguyen on 5/11/15.
//  Copyright (c) 2015 Tam Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController

@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (assign) float total;
@property (assign) float tip;
@property (assign) float subtotal;
@property (assign) float percent;

@property (assign) BOOL bRoundTip;
@property (assign) BOOL bRoundTotal;
@property (assign) BOOL bDontRound;

@property (strong, nonatomic) NSString *strSubTotal;

@property (strong, nonatomic) IBOutlet UILabel *label_subtotal;
@property (strong, nonatomic) IBOutlet UILabel *label_tip;
@property (strong, nonatomic) IBOutlet UILabel *label_total;

@property (assign) float default_tip;
@property (assign) float default_tax;
@property (assign) BOOL has_default_tip;
@property (assign) BOOL has_default_tax;

@property (strong, nonatomic) IBOutlet UIButton *button_1;
@property (strong, nonatomic) IBOutlet UIButton *button_2;
@property (strong, nonatomic) IBOutlet UIButton *button_3;
@property (strong, nonatomic) IBOutlet UIButton *button_4;
@property (strong, nonatomic) IBOutlet UIButton *button_5;
@property (strong, nonatomic) IBOutlet UIButton *button_6;
@property (strong, nonatomic) IBOutlet UIButton *button_7;
@property (strong, nonatomic) IBOutlet UIButton *button_8;
@property (strong, nonatomic) IBOutlet UIButton *button_9;
@property (strong, nonatomic) IBOutlet UIButton *button_0;
@property (strong, nonatomic) IBOutlet UIButton *button_dot;
@property (strong, nonatomic) IBOutlet UIButton *button_back;

- (IBAction)touchDown_b1:(id)sender;
- (IBAction)touchDown_b2:(id)sender;
- (IBAction)touchDown_b3:(id)sender;
- (IBAction)touchDown_b4:(id)sender;
- (IBAction)touchDown_b5:(id)sender;
- (IBAction)touchDown_b6:(id)sender;
- (IBAction)touchDown_b7:(id)sender;
- (IBAction)touchDown_b8:(id)sender;
- (IBAction)touchDown_b9:(id)sender;
- (IBAction)touchDown_b0:(id)sender;
- (IBAction)touchDown_dot:(id)sender;
- (IBAction)touchDown_back:(id)sender;

@end


