//
//  NGItem.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 29/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGItem.h"
#import "NGFrame.h"
#import "NGDataManager.h"
#import "NGSQLiteDataBaseManager.h"

@implementation NGItem

@synthesize tipo, priceItem, productDescription, frame, nameItem;

- (instancetype)initWithType:(NSInteger)productType
{
    self = [super init];
    
    tipo = productType;
    
    if (self) {
        switch (tipo) {
            case 0:
                frame = [DB_MANAGER getFrameByBarCode:DATA_MANAGER.currentBarCode];
                self.priceItem = frame.price;
                self.productDescription = frame.frameDescription;
                self.nameItem = frame.name;
                self.imageName = frame.image;
                break;
            case 1:
                self.priceItem = NG_PROGRESSIVE_PRICE;
                self.nameItem = @"Progressive vision";
                self.productDescription = [DATA_MANAGER getDescriptionOfItem:tipo];
                 break;
            case 2:
                self.priceItem = NG_SINGLEVIS_PRICE;
                self.nameItem = @"Single Vision";
                self.productDescription = [DATA_MANAGER getDescriptionOfItem:tipo];
                break;
            case 3:
                self.priceItem = NG_AR_PRICE;
                self.nameItem = @"Anti-reflactive";
                self.productDescription = [DATA_MANAGER getDescriptionOfItem:tipo];
                break;
            case 4:
                self.priceItem = NG_HIGHINDEX_PRICE;
                self.nameItem = @"High Index";
                self.productDescription = [DATA_MANAGER getDescriptionOfItem:tipo];
                break;
            case 5:
                self.priceItem = NG_PHOTOCHROMIC_PRICE;
                self.nameItem = @"Photochromic";
                self.productDescription = [DATA_MANAGER getDescriptionOfItem:tipo];
                break;

            default:
                break;
        }
    }
    return self;
}

+(NGItem *)createItemWithType:(NSInteger)productType
{
    NGItem *item = [[NGItem alloc] initWithType:productType];
    return item;
}

@end
