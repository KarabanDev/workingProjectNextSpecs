//
//  NGGlassesOptionsViewController.h
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGDataManager.h"

@interface NGGlassesOptionsViewController : UIViewController

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *photochromicButtons;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *optionsLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allPricesOfChoices;

@property (retain, nonatomic) IBOutlet UILabel *selectLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *frameLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UIView *photochromicOptionsView;
@property (weak, nonatomic) IBOutlet UIButton *photochromicBtn;
@property (weak, nonatomic) IBOutlet UILabel *secondChoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdChoice;


@property (weak, nonatomic) IBOutlet UILabel *priceOfFrame;
@property (weak, nonatomic) IBOutlet UILabel *priceOfType;
@property (weak, nonatomic) IBOutlet UILabel *priceOfChoice;
@property (weak, nonatomic) IBOutlet UILabel *priceOfSecondChoice;
@property (weak, nonatomic) IBOutlet UILabel *priceOfThirdChoice;


- (IBAction)selectedBtn:(UIButton *)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)nextBtnPressed:(id)sender;

@end
