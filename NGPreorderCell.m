//
//  NGPreorderCell.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 23/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGPreorderCell.h"

@implementation NGPreorderCell

@synthesize frameImage;
@synthesize brendLabel, nameOfItem, quantityLabel, priceLabel;
@synthesize plusBtn, minusBtn, changeBtn, removeBtn;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
