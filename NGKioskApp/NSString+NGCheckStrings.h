//
//  NSString+NGCheckStrings.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 22/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NGCheckStrings)<UIAlertViewDelegate>

- (BOOL)stringIsNotNil:(NSString *)string;
- (BOOL)validEmail:(NSString *)emailString;
- (BOOL)checkIfString:(NSString *)string isEqualTo:(NSString *)equalString;

- (void)showAlertWithMessage:(NSString *)message;


@end
