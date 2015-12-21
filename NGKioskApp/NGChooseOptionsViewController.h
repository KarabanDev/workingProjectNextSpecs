//
//  NGChooseOptionsViewController.h
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGDataManager.h"

@interface NGChooseOptionsViewController : UIViewController

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (retain, nonatomic) IBOutlet UILabel *selectLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *frameLabel;
@property (retain, nonatomic) IBOutlet UILabel *lensesLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;

- (IBAction)selectedBtn:(UIButton *)sender;
- (IBAction)nextBtnPressed:(id)sender;

@end
