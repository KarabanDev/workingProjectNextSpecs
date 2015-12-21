//
//  DropboxAPI.m
//  DropboxAPI
//
//  Created by Work Inteleks on 6/9/15.
//  Copyright (c) 2015 Eschenko Evgeny. All rights reserved.
//

#import "DropboxAPI.h"

@implementation DropboxAPI

@synthesize restClient;

- (id)init
{
    if (self = [super init])
    {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    
    return self;
}

- (void)login:(UIViewController *)controller
{
    if (![[DBSession sharedSession] isLinked])
    {
        [[DBSession sharedSession] linkFromController:controller];
    }
    else
    {
        NSLog(@"App linked successfully!");
    }
}

- (void)uploadToDropbox:(NSData *)data withName:(NSString *)name
{
    NSLog(@"Start Upload");
    
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    
    [data writeToFile:file atomically:YES];
    
    [restClient uploadFile:name toPath:@"Dropbox" withParentRev:nil fromPath:file];
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    NSLog(@"File upload failed with error: %@", error);
}

@end
