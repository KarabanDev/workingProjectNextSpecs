//
//  NGFrame.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 09/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NGFrame : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSString *SKU;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *frameDescription;
@property (nonatomic, assign) float A;
@property (nonatomic, assign) float B;
@property (nonatomic, assign) float ED;
@property (nonatomic, assign) float DBL;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSString *image;

@end
