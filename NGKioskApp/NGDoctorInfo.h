//
//  NGDoctorInfo.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 19/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGDoctorInfo : NSObject

@property (nonatomic, strong) NSString *doctorName;
@property (nonatomic, strong) NSString *doctorOfficeAddress;
@property (nonatomic, strong) NSString *doctorCity;
@property (nonatomic, strong) NSString *doctorState;
@property (nonatomic, strong) NSString *doctorZip;
@property (nonatomic, strong) NSString *doctorPhone;

+ (void)saveInUserDefaults:(NGDoctorInfo *)doctor;

@end
