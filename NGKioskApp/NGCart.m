//
//  NGCart.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 29/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGCart.h"

@interface NGCart ()
{
    NSMutableArray *itemsArray;
}

- (void)replaceItem:(NGItem *)item;
- (BOOL)existsItem:(NGItem *)aItem;

@end

@implementation NGCart

@synthesize uuid;

- (instancetype)initWithCustomer:(NSString *)customerID
{
    self = [super init];
    
    if (self)
    {
        itemsArray = [NSMutableArray new];
        uuid = customerID;
    }
    return self;
}

- (NSMutableArray *)getAllItems
{
    return itemsArray;
}

- (void)addItemToCart:(NGItem *)item
{
    if (itemsArray.count)
        [self replaceItem:item];
    else
        [itemsArray addObject:item];
}

- (void)replaceItem:(NGItem *)item
{
    if ([self existsItem:item])
    {
        for (int i = 0; i < itemsArray.count; i++)
        {
            if ([[itemsArray[i] nameItem] isEqualToString:item.nameItem])
            {
                [itemsArray replaceObjectAtIndex:i withObject:item];
            }
        }
    }
    else
        [itemsArray addObject:item];
}

- (void)removeItem:(NGItem *)item
{
    if (itemsArray.count)
    {
        [itemsArray removeObject:item];
    }
}

#pragma mark - Common

- (BOOL)existsItem:(NGItem *)aItem
{
    for (NGItem *item in itemsArray)
    {
        if ([item.nameItem isEqualToString:aItem.nameItem])
            return YES;
    }
    
    return NO;
}

#pragma mark - Total Price

- (float)getTotalPrice
{
    float totalPrice = 0;
    
    for (NGItem *i in itemsArray)
    {
        totalPrice += i.priceItem;
    }
    
    return totalPrice;
}

@end
