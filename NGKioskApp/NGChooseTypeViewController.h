//
//  NGChooseTypeViewController.h
//  NGKioskApp
//
//  Created by Work Inteleks on 6/24/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGDataManager.h"

@interface NGChooseTypeViewController : UIViewController

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (retain, nonatomic) IBOutlet UILabel *selectLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *frameLabel;
@property (retain, nonatomic) IBOutlet UILabel *lensesLabel;

- (IBAction)selectedBtn:(UIButton *)sender;

@end
