//
//  NGGlassesTypeViewController.h
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGDataManager.h"

@interface NGGlassesTypeViewController : UIViewController

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (retain, nonatomic) IBOutlet UILabel *selectLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *frameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfFrame;
@property (weak, nonatomic) IBOutlet UILabel *priceOfChoice;

- (IBAction)selectedBtn:(UIButton *)sender;

- (IBAction)backBtnPressed:(id)sender;

@end
