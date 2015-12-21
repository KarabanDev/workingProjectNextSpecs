//
//  NGCustomer.h
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGCustomer : NSObject

@property (nonatomic, strong) NSString *customerId;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *customerLastName;
@property (nonatomic, strong) NSString *customerStreet;
@property (nonatomic, strong) NSString *customerCity;
@property (nonatomic, strong) NSString *customerState;
@property (nonatomic, strong) NSString *customerZipCode;
@property (nonatomic, strong) NSString *customerPhoneNumber;
@property (nonatomic, strong) NSString *customerEmail;

+ (void)saveInUserDefaults:(NGCustomer *)customer;

@end
