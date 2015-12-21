//
//  UIImage+NGUIResizedImage.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 16/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "UIImage+NGUIResizedImage.h"

@implementation UIImage (NGUIResizedImage)

+ (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
}


+ (void)endImageContext
{
    UIGraphicsEndImageContext();
}


+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    [self beginImageContextWithSize:newSize];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    return newImage;
}

@end
