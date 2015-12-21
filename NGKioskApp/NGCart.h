//
//  NGCart.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 29/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGItem.h"

@interface NGCart : NSObject

@property (nonatomic, strong) NSString *uuid;

- (instancetype)initWithCustomer:(NSString *)customerID;

- (NSMutableArray *)getAllItems;
- (void)addItemToCart:(NGItem *)item;
- (void)removeItem:(NGItem *)item;
- (float)getTotalPrice;

@end
