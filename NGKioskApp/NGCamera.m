//
//  NGCamera.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGCamera.h"

@interface NGCamera () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    AVCaptureStillImageOutput *stillImageOutput;
    AVCaptureMetadataOutput *metaDataOutput;
    AVCaptureConnection *photoConnection;
    
    UIView *previewView;
    
    BOOL front;
    
    float scale;
    
    AVCaptureDevice *device;
}

@end

@implementation NGCamera

@synthesize delegate;

+ (NSArray *)metaDataObjectTypes
{
    NSMutableArray *types = [@[AVMetadataObjectTypeQRCode,
                               AVMetadataObjectTypeCode39Code,
                               AVMetadataObjectTypeCode39Mod43Code,
                               AVMetadataObjectTypeEAN13Code,
                               AVMetadataObjectTypeEAN8Code,
                               AVMetadataObjectTypeCode93Code,
                               AVMetadataObjectTypeCode128Code,
                               AVMetadataObjectTypePDF417Code,
                               AVMetadataObjectTypeAztecCode] mutableCopy];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
    {
        [types addObjectsFromArray:@[
                                     AVMetadataObjectTypeInterleaved2of5Code,
                                     AVMetadataObjectTypeITF14Code,
                                     AVMetadataObjectTypeDataMatrixCode
                                     ]];
    }
    
    return types;
}

- (instancetype)initWithFront:(BOOL)aFront
{
    self = [super init];
    
    if (self)
    {
        session = [AVCaptureSession new];
        
        front = !aFront;
        [self setFrontCamera:aFront];
        
        metaDataOutput = [AVCaptureMetadataOutput new];
        [session addOutput:metaDataOutput];
        
        [metaDataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [metaDataOutput setMetadataObjectTypes:[NGCamera metaDataObjectTypes]];
        
        videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        
        [[videoPreviewLayer connection] setVideoOrientation:(AVCaptureVideoOrientation)[UIApplication sharedApplication].statusBarOrientation];
        
        videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        previewView = [UIView new];
        
        [previewView.layer addSublayer:videoPreviewLayer];
        
        stillImageOutput = [AVCaptureStillImageOutput new];
        stillImageOutput.outputSettings = @{ AVVideoCodecKey : AVVideoCodecJPEG };
        
        [session addOutput:stillImageOutput];
        
        photoConnection = [self getVideoConnection:stillImageOutput];
        
        session.sessionPreset = AVCaptureSessionPresetHigh;
        
        [session startRunning];
        
        scale = 1.f;
    }
    
    return self;
}

- (void)dealloc
{
    [self stopCamera];
    
    videoPreviewLayer = nil;
}

- (void)stopCamera
{
    [session stopRunning];
    
    session = nil;
}

- (void)startCamera
{
    if (![session isRunning])
    {
        [session startRunning];
    }
}

- (void)setFrontCamera:(BOOL)aFront
{
    if (front == aFront)
        return;
    
    front = aFront;
    
    [session beginConfiguration];
    
    if (session.inputs.count)
    {
        [session removeInput:session.inputs[0]];
    }
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *dev in devices)
    {
        if (dev.position == (aFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack))
            device = dev;
    }
    
    AVCaptureDeviceInput *newInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    [session addInput:newInput];
    
    [session commitConfiguration];
}

#pragma mark PreviewLayer

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    return videoPreviewLayer;
}

- (void)setPreviewContainer:(UIView *)container
{
    [previewView removeFromSuperview];
    
    CGRect bounds = container.layer.bounds;
    
    videoPreviewLayer.bounds = bounds;
    videoPreviewLayer.position = CGPointMake(CGRectGetMidX( bounds ), CGRectGetMidY( bounds ));
    
    previewView.frame = CGRectMake(0, 0, container.frame.size.width, container.frame.size.height);
    
    [container addSubview:previewView];
}

#pragma mark AVCaptureConnection

- (AVCaptureConnection *)getVideoConnection:(AVCaptureOutput *)output
{
    for (AVCaptureConnection *connection in output.connections)
        for (AVCaptureInputPort *port in connection.inputPorts)
            if ([port.mediaType isEqual:AVMediaTypeVideo])
                return connection;
    
    return nil;
}

- (void)takePhoto:(void(^)(BOOL success, UIImage *image))completion
{
    photoConnection = [self getVideoConnection:stillImageOutput];
    photoConnection.videoScaleAndCropFactor = scale;
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:photoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         
         if (imageData)
         {
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             
             if (front) {
                 UIImage *flippedImage = [UIImage imageWithCGImage:image.CGImage
                                                             scale:image.scale orientation:UIImageOrientationLeftMirrored];
                 completion(YES, flippedImage);
             } else {
                 completion(YES, image);
             }
         }
         else
             completion(NO, nil);
     }];
}

- (float)scale
{
    return scale;
}

- (void)setScale:(float)aScale
{
    //    if( aScale < 1.f )
    //        aScale = 1.f;
    //
    //    if( aScale > 10.f)
    //        aScale = 10.f;
    //
    //    if( videoMode )
    //    {
    //        if ([self deviceScaleSupport] && !front)
    //        {
    //            if( aScale > device.activeFormat.videoMaxZoomFactor)
    //                aScale = device.activeFormat.videoMaxZoomFactor;
    //
    //            NSError *error = nil;
    //
    //            if ([device lockForConfiguration:&error])
    //            {
    //                [device setVideoZoomFactor:aScale];
    //                [device unlockForConfiguration];
    //            }
    //        }
    //        else
    //        {
    //            aScale = 1.f;
    //        }
    //    }
    //
    //    self->scale = aScale;
    //
    //    float realScale = videoMode ? aScale - ((aScale - 1.0) / 1.02f) : aScale;
    //    
    //    previewView.transform = CGAffineTransformMakeScale( realScale, realScale );
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    NSMutableArray *codes = [NSMutableArray new];
    
    for (AVMetadataObject *metaData in metadataObjects)
    {
        AVMetadataMachineReadableCodeObject *barCodeObject = (AVMetadataMachineReadableCodeObject *)[videoPreviewLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metaData];
        
        if (barCodeObject)
        {
            //[codes addObject:barCodeObject];
            [codes addObject:barCodeObject.stringValue];
            break;
        }
        break;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(foundScanCodes:)])
    {
        [delegate foundScanCodes:codes];
    }
}

@end
