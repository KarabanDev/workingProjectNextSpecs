//
//  DropboxAPI.h
//  DropboxAPI
//
//  Created by Work Inteleks on 6/9/15.
//  Copyright (c) 2015 Eschenko Evgeny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface DropboxAPI : NSObject <DBRestClientDelegate>

@property (nonatomic, strong) DBRestClient *restClient;

- (void)login:(UIViewController *)controller;
- (void)uploadToDropbox:(NSData *)data withName:(NSString *)name;

@end
