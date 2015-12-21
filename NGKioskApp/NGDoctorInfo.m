//
//  NGDoctorInfo.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 19/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGDoctorInfo.h"

@implementation NGDoctorInfo

@synthesize doctorName, doctorOfficeAddress, doctorCity, doctorState, doctorZip, doctorPhone;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:doctorName forKey:@"doctorName"];
    [encoder encodeObject:doctorOfficeAddress forKey:@"doctorOfficeAddress"];
    [encoder encodeObject:doctorCity forKey:@"doctorCity"];
    [encoder encodeObject:doctorState forKey:@"doctorState"];
    [encoder encodeObject:doctorZip forKey:@"doctorZip"];
    [encoder encodeObject:doctorPhone forKey:@"doctorPhone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.doctorName = [decoder decodeObjectForKey:@"doctorName"];
        self.doctorOfficeAddress = [decoder decodeObjectForKey:@"doctorOfficeAddress"];
        self.doctorCity = [decoder decodeObjectForKey:@"doctorCity"];
        self.doctorState = [decoder decodeObjectForKey:@"doctorState"];
        self.doctorZip = [decoder decodeObjectForKey:@"doctorZip"];
        self.doctorPhone = [decoder decodeObjectForKey:@"doctorPhone"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Doctor: %@", self.doctorName];
}

#pragma mark Helpers

+ (void)saveInUserDefaults:(NGDoctorInfo *)doctor
{
    NSLog(@"Saved DOCTOR: %@", doctor);
    
    NSData *encodedDoctor = [NSKeyedArchiver archivedDataWithRootObject:doctor];
    [[NSUserDefaults standardUserDefaults] setObject:encodedDoctor forKey:@"doctor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
