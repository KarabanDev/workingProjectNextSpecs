//
//  SQLiteDataBaseManager.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 08/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_MANAGER [NGSQLiteDataBaseManager sharedInstance]

@class NGFrame;

@interface NGSQLiteDataBaseManager : NSObject

+ (instancetype)sharedInstance;

- (void)saveFrame:(NGFrame *)frame;

- (NSMutableArray *)getAllFrames;

- (NGFrame *)getFrameByBarCode:(NSString *)frameBarCode;
- (NGFrame *)getFrameByID:(NSInteger)frameID;
- (NSArray *)getFramesByParameter:(NSString *)parameter;

@end
