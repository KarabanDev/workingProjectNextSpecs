//
//  NGCamera.h
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol NGCameraDelegate <NSObject>

@optional
- (void)foundScanCodes:(NSArray *)codes;
@end

@interface NGCamera : NSObject

@property (nonatomic, assign) id <NGCameraDelegate> delegate;

- (instancetype)initWithFront:(BOOL)aFront;

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer;
- (void)setPreviewContainer:(UIView *)container;

- (void)setFrontCamera:(BOOL)front;

- (void)takePhoto:(void(^)(BOOL success, UIImage *image))completion;

- (void)setScale:(float)aScale;
- (float)scale;

- (void)startCamera;
- (void)stopCamera;

@end
