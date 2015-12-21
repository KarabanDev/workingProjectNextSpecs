//
//  SQLiteDataBaseManager.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 08/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import <sqlite3.h>
#import "NGSQLiteDataBaseManager.h"
#import "NGFrame.h"

@interface NGSQLiteDataBaseManager()
{
    sqlite3_stmt *compiledStatement;
    sqlite3 *sqliteHandler;
    NSString *documentsDirectory;
    NSString *databasePath;
    NSString *databaseFileName;
    const char *dbpath;
}

-(void)copyDatabaseIntoDocumentsDirectory;

@end


@implementation NGSQLiteDataBaseManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken = 0;
    static NGSQLiteDataBaseManager *_sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[NGSQLiteDataBaseManager alloc] initWithDatabaseFilename:@"framesInfo.sql"];
    });
    
    return _sharedInstance;
}
- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename
{
        NSLog(@"%s", __PRETTY_FUNCTION__);
        // Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
        
        // Keep the database filename.
        databaseFileName = dbFilename;
        databasePath = [documentsDirectory stringByAppendingPathComponent:databaseFileName];
        
        dbpath = [databasePath UTF8String];

        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory
{
    // Check if the database file exists in the documents directory.
    
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:databaseFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseFileName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        NSLog(@"Data base was copied!\n\n\n");
        // Check if any error occurred during copying and display it.
        if (error != nil)
            NSLog(@"%@", [error localizedDescription]);
    
        if (sqlite3_open(dbpath, &sqliteHandler) == SQLITE_OK)
        {
            char *errMsg;
            NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS frames (";
            sql_stmt = [sql_stmt stringByAppendingString:@"'ID' INTEGER PRIMARY KEY AUTOINCREMENT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"'SKU' TEXT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"'Description' TEXT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"'A' VARCHAR,"];
            sql_stmt = [sql_stmt stringByAppendingString:@"'B' VARCHAR,"];
            sql_stmt = [sql_stmt stringByAppendingString:@"'DBL' VARCHAR, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"'Price' VARCHAR, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"'Image' TEXT);"];
            
            if (sqlite3_exec(sqliteHandler, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
                NSLog(@"Failed to create table");
            else
                 NSLog(@"Frames table created successfully");
            
            sqlite3_close(sqliteHandler);
        }else
             NSLog(@"Can not open database with error -> %s\n", sqlite3_errmsg(sqliteHandler));
    }
}

- (void)saveFrame:(NGFrame *)frame
{
    NSString *sqlQuery = [NSString new];
    
        if (frame.ID > 0) {
          //  NSLog(@"Exitsing data, Update Please");
          sqlQuery = [NSString stringWithFormat:@"UPDATE Frames set 'SKU' = '%@', 'Description' = '%@', 'A' = '%@', 'B' = '%@', 'DBL' = '%@', 'Price' = '%@', 'Image' = '%@' WHERE 'ID' = ?",
                                  [NSString stringWithFormat:@"%ld",(long)frame.SKU],
                                   frame.frameDescription,
                                   [NSString stringWithFormat:@"%f", frame.A],
                                   [NSString stringWithFormat:@"%f",frame.B],
                                   [NSString stringWithFormat:@"%f",frame.DBL],
                                   [NSString stringWithFormat:@"%f",frame.price],
                                   frame.image];
        }
        else{
            //NSLog(@"New data, Insert Please");
            sqlQuery = [NSString stringWithFormat:
                                   @"INSERT INTO Frames ('SKU', 'Description', 'A', 'B', 'DBL', 'Price', 'Image') VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                                   frame.SKU,
                                   frame.frameDescription,
                                   [NSString stringWithFormat:@"%f", frame.A],
                                   [NSString stringWithFormat:@"%f",frame.B],
                                   [NSString stringWithFormat:@"%f",frame.DBL],
                                   [NSString stringWithFormat:@"%f",frame.price],
                                   frame.image];
        }
}

- (NGFrame *)getFrameByID:(NSInteger)frameID
{
    NGFrame *frame;
    
    if (sqlite3_open(dbpath, &sqliteHandler) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM 'frames' WHERE 'ID'=%d",
                              (int)frameID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(sqliteHandler, query_stmt, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                frame = [NGFrame new];

                frame.ID = sqlite3_column_int(compiledStatement, 0);
                frame.SKU = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                frame.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                frame.frameDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                frame.A = sqlite3_column_double(compiledStatement, 4);
                frame.B = sqlite3_column_double(compiledStatement, 5);
                frame.ED = sqlite3_column_double(compiledStatement, 6);
                frame.DBL = sqlite3_column_double(compiledStatement, 7);
                frame.price = sqlite3_column_double(compiledStatement, 8);
                frame.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
            }
            sqlite3_finalize(compiledStatement);
        }
        sqlite3_close(sqliteHandler);
    }
    return frame;
}

- (NSArray *)getFramesByParameter:(NSString *)parameter
{
    NSMutableArray *framesList;
    
    NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM `frame` AS `frame` WHERE (`frame`.`SKU` LIKE '%@%%' OR `frame`.`NAME` LIKE '%@%%' OR `frame`.`B` LIKE '%@%%' OR `frame`.`A` LIKE '%@%%' OR `frame`.`Description` LIKE '%@%%' OR `frame`.`DBL` LIKE '%@%%');" ,parameter, parameter, parameter, parameter, parameter, parameter];
    
    const char *query_stmt = [querySQL UTF8String];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqliteHandler);
    
    NSLog(@"querySQLquerySQLquerySQL - %@\n\n",querySQL);
    if(openDatabaseResult == SQLITE_OK)
    {
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqliteHandler, query_stmt, -1, &(compiledStatement), NULL);
        
        if(prepareStatementResult == SQLITE_OK)
        {
            framesList = [[NSMutableArray alloc] init];

            while (sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                NGFrame *frame = [NGFrame new];
                
                frame.ID = sqlite3_column_int(compiledStatement, 0);
                frame.SKU = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                frame.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                frame.frameDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                frame.A = sqlite3_column_double(compiledStatement, 4);
                frame.B = sqlite3_column_double(compiledStatement, 5);
                frame.ED = sqlite3_column_double(compiledStatement, 6);
                frame.DBL = sqlite3_column_double(compiledStatement, 7);
                frame.price = sqlite3_column_double(compiledStatement, 8);
                frame.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                
                [framesList addObject:frame];
            }
            
            sqlite3_finalize(compiledStatement);
        }
        sqlite3_close(sqliteHandler);
    }
    return framesList;
}

- (NSArray *)getAllFrames
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSMutableArray *framesList = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &sqliteHandler) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM `frame`";
        const char *query_stmt = [querySQL UTF8String];
        
        BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqliteHandler);
        
        if(openDatabaseResult == SQLITE_OK)
        {
            BOOL prepareStatementResult = sqlite3_prepare_v2(sqliteHandler, query_stmt, -1, &(compiledStatement), NULL);
            
            if(prepareStatementResult == SQLITE_OK)
            {
                while (sqlite3_step(compiledStatement) == SQLITE_ROW)
                {
                    NGFrame *frame = [NGFrame new];
                    frame.ID = sqlite3_column_int(compiledStatement, 0);
                    frame.SKU = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                    frame.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                    frame.frameDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                    frame.A = sqlite3_column_double(compiledStatement, 4);
                    frame.B = sqlite3_column_double(compiledStatement, 5);
                    frame.ED = sqlite3_column_double(compiledStatement, 6);
                    frame.DBL = sqlite3_column_double(compiledStatement, 7);
                    frame.price = sqlite3_column_double(compiledStatement, 8);
                    frame.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                
                    [framesList addObject:frame];
                }
            }
            sqlite3_finalize(compiledStatement);
        }
        sqlite3_close(sqliteHandler);
    }
    return [framesList copy];
}

- (NGFrame *)getFrameByBarCode:(NSString *)frameBarCode
{
    NGFrame *frame;
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM `frame` WHERE `frame`.`SKU`=%@",
                          frameBarCode];
    
    const char *query_stmt = [querySQL UTF8String];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqliteHandler);
    
    if(openDatabaseResult == SQLITE_OK)
    {
         BOOL prepareStatementResult = sqlite3_prepare_v2(sqliteHandler, query_stmt, -1, &(compiledStatement), NULL);
        
        if(prepareStatementResult == SQLITE_OK)
        {
                while(sqlite3_step(compiledStatement) == SQLITE_ROW)
                {
                    NSLog(@"QUERY OK");
                    frame = [NGFrame new];
                    
                    frame.ID = sqlite3_column_int(compiledStatement, 0);
                    frame.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                    frame.frameDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                    frame.A = sqlite3_column_double(compiledStatement, 4);
                    frame.B = sqlite3_column_double(compiledStatement, 5);
                    frame.ED = sqlite3_column_double(compiledStatement, 6);
                    frame.DBL = sqlite3_column_double(compiledStatement, 7);
                    frame.price = sqlite3_column_double(compiledStatement, 8);
                    frame.image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                }
        }
        else
        {
            // In the database cannot be opened then show the error message on the debugger.
            NSLog(@"%s", sqlite3_errmsg(sqliteHandler));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
    }
    // Close the database.
    sqlite3_close(sqliteHandler);
    
    NSLog(@"FRAME::: \n%d \n%@ \n%@ \n%f \n%f \n%f \n%f \n%f \n%@", frame.ID, frame.name, frame.frameDescription, frame.A, frame.B, frame.ED, frame.DBL, frame.price, frame.image);
    return frame;
}


@end
