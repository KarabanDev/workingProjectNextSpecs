//
//  UIImage+NGUIResizedImage.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 16/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NGUIResizedImage)

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
