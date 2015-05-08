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

@property (nonatomic,strong) UIColor *BLUE;
@property (nonatomic,strong) UIColor *GRAY;
@property (nonatomic,strong) UIColor *RED;
@property (nonatomic,strong) UIColor *BLACK;

@property (nonatomic,strong) NSArray *arrPercent;
@property (nonatomic,strong) NSArray *arrPeople;

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

@property (nonatomic,strong) NSNumber *percent;
@property (nonatomic,strong) NSNumber *total;
@property (nonatomic,strong) NSNumber *people;

@end