//
//  NSString+NGCheckStrings.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 22/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NSString+NGCheckStrings.h"

@implementation NSString (NGCheckStrings)

- (BOOL)stringIsNotNil:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""].length;
}

- (BOOL)validEmail:(NSString *)emailString
{
    if ([emailString length] == 0)
    {
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:nil];
    
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString
                                                     options:0
                                                       range:NSMakeRange(0, [emailString length])];
    
    if (regExMatches == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)checkIfString:(NSString *)string isEqualTo:(NSString *)equalString
{
    if ([string isEqualToString:equalString])
        return YES;
    else
        return NO;
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
