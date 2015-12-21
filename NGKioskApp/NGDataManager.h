//
//  NGDataManager.h
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NGCart.h"

@class NGCustomer;
@class NGDoctorInfo;

#define NG_FRAME_PRICE 39.00
#define NG_POLARIZED_PRICE 0.00
#define NG_SINGLEVIS_PRICE 90.00
#define NG_PROGRESSIVE_PRICE 150.00
#define NG_HIGHINDEX_PRICE 30.00
#define NG_AR_PRICE 50.00
#define NG_PHOTOCHROMIC_PRICE 50.00

#define DATA_MANAGER [NGDataManager sharedInstance]

typedef NS_ENUM (NSInteger, NGScenarioType) {
    NGScenarioTypeGlasses,
    NGScenarioTypeSunglasses,
};

typedef NS_ENUM (NSInteger, NGPrescriptionChoice) {
    NGPrescriptionChoiceYes,
    NGPrescriptionChoiceAtHome,
    NGPrescriptionChoiceNo
};

@interface NGDataManager : NSObject

@property (nonatomic, assign) NGScenarioType currentScenario;
@property (nonatomic, assign) NGPrescriptionChoice currentChoice;

@property (nonatomic, strong) NSString *currentBarCode;

@property (nonatomic, strong) NGCustomer *currentCustomer;
@property (nonatomic, strong) NGDoctorInfo *doctor;

@property (nonatomic, retain) NSMutableDictionary *optionsSunglasses;
@property (nonatomic) float priceSunglasses;

@property (nonatomic, retain) NSMutableDictionary *optionsGlasses;
@property (nonatomic) float priceGlasses;

@property (nonatomic, strong) NGCart *currentCart;
@property (nonatomic, strong) NGItem *currentItem;


+ (instancetype)sharedInstance;

- (void)setData:(NSString *)data forKey:(NSString *)key;

- (NGItem *)createNewItemWithType:(NGItemType )itemType;

- (NSString *)getDescriptionOfItem:(NSInteger )itemType;

- (void)checkIfCartWithItemsContainsFrame:(NGItem *)item;

@end
