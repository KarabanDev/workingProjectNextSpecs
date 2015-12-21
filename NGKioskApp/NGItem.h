//
//  NGItem.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 29/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGFrame;

typedef NS_ENUM(NSInteger, NGItemType) {
    NGItemTypeFrame = 0,
    NGItemTypeProgressive = 1,
    NGItemTypeSingleVision = 2,
    NGItemTypeAntiReflective = 3,
    NGItemTypeHightIndex = 4,
    NGItemTypePhotochromic = 5
};

@interface NGItem : NSObject

@property (nonatomic, assign) NGItemType tipo;
@property (nonatomic, assign) float priceItem;
@property (nonatomic, strong) NSString *nameItem;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NGFrame *frame;
@property (nonatomic, strong) NSString *imageName;

+ (NGItem *)createItemWithType:(NSInteger) productType;

@end
