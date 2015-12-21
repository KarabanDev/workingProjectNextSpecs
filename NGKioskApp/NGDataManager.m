//
//  NGDataManager.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGDataManager.h"
#import "NGCustomer.h"
#import "NGDoctorInfo.h"
#import "NGFrame.h"

@interface NGDataManager ()
{
    NGCustomer *currentCustomer;
}

@end

@implementation NGDataManager

@synthesize currentBarCode;
@synthesize currentCustomer;
@synthesize doctor;
@synthesize optionsSunglasses;
@synthesize priceSunglasses;
@synthesize optionsGlasses;
@synthesize priceGlasses;
@synthesize currentCart;
@synthesize currentItem;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken = 0;
    static id _sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        currentCustomer = [[NGCustomer alloc] init];
        doctor = [NGDoctorInfo new];
        
        optionsSunglasses = [NSMutableDictionary new];
        priceSunglasses = 39.00;
        
        optionsGlasses = [NSMutableDictionary new];
        priceGlasses = 39.00;
        
        currentCart = [[NGCart alloc] initWithCustomer:currentCustomer.customerId];
    }
    return self;
}

- (void)setData:(NSString *)data forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

- (NGItem *)createNewItemWithType:(NGItemType )itemType
{
    return currentItem = [NGItem createItemWithType:itemType];
}

- (NSString *)getDescriptionOfItem:(NSInteger)itemType
{
    NSString *productDescription = [NSString new];

    NSString *key = [NSString new];
    
    switch (itemType) {
        case 1 :
            key = @"Progressive";
            break;
        case 2:
            key = @"SingleVision";
            break;
        case 3:
            key = @"Reflective";
            break;
        case 4:
            key = @"HightIndex";
            break;
        case 5:
            key = @"Photochromic";
            break;
  
        default:
            break;
    }
    return productDescription = NSLocalizedString(key, nil);
}

- (void)checkIfCartWithItemsContainsFrame:(NGItem *)item
{
    __block NSInteger foundIndx = NSNotFound;
    
    [[self.currentCart getAllItems] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if (item.tipo == NGItemTypeFrame)
        {
            foundIndx = idx;
            *stop = YES;
        }
    }];
    
    if (foundIndx != NSNotFound)
        [[currentCart getAllItems] replaceObjectAtIndex:0 withObject:currentItem];
    else
        [currentCart addItemToCart:currentItem];
}

@end
