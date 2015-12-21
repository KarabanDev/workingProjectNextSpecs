//
//  NGPreorderCell.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 23/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGPreorderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *frameImage;

@property (weak, nonatomic) IBOutlet UILabel *brendLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameOfItem;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end
