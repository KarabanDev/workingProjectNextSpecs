//
//  NGCustomer.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGCustomer.h"

@interface NGCustomer ()

+ (NSString *)uniqueId;

@end

@implementation NGCustomer

@synthesize customerId;
@synthesize customerName, customerLastName;
@synthesize customerStreet, customerCity, customerState, customerZipCode, customerPhoneNumber, customerEmail;

- (instancetype)init
{
    self = [super init];
    if (self) {
        customerId = [NGCustomer uniqueId];
    }
    return self;
}

#pragma mark - Common

+ (NSString *)uniqueId
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
    CFRelease(uuidStringRef);
    
    return uuid;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:customerId forKey:@"customerID"];
    [encoder encodeObject:customerName forKey:@"customerName"];
    [encoder encodeObject:customerLastName forKey:@"customerLastName"];
    [encoder encodeObject:customerStreet forKey:@"customerStreet"];
    [encoder encodeObject:customerCity forKey:@"customerCity"];
    [encoder encodeObject:customerState forKey:@"customerState"];
    [encoder encodeObject:customerZipCode forKey:@"customerZipCode"];
    [encoder encodeObject:customerPhoneNumber forKey:@"customerPhoneNumber"];
    [encoder encodeObject:customerEmail forKey:@"customerEmail"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.customerId = [decoder decodeObjectForKey:@"customerID"];
        self.customerName = [decoder decodeObjectForKey:@"customerName"];
        self.customerLastName = [decoder decodeObjectForKey:@"customerLastName"];
        self.customerStreet = [decoder decodeObjectForKey:@"customerStreet"];
        self.customerCity = [decoder decodeObjectForKey:@"customerCity"];
        self.customerState = [decoder decodeObjectForKey:@"customerState"];
        self.customerZipCode = [decoder decodeObjectForKey:@"customerZipCode"];
        self.customerPhoneNumber = [decoder decodeObjectForKey:@"customerPhoneNumber"];
        self.customerEmail = [decoder decodeObjectForKey:@"customerEmail"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Customer: %@ %@ | %@", self.customerName, self.customerLastName, self.customerEmail];
}

#pragma mark Helpers

+ (void)saveInUserDefaults:(NGCustomer *)customer
{
    NSLog(@"Saved CUSTOMER: %@", customer);
    
    NSData *encodedCustomer = [NSKeyedArchiver archivedDataWithRootObject:customer];
    [[NSUserDefaults standardUserDefaults] setObject:encodedCustomer forKey:@"customer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
