//
//  NGHelpScreenController.h
//  NGKioskApp
//
//  Created by Andrey Karaban on 26/10/15.
//  Copyright © 2015 ACEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NGHowItWorksScreenControllerDelegate <NSObject>

- (void)removeController;
- (void)getStarted;
@end

@interface NGHowItWorksScreenController : UIViewController

@property (nonatomic, assign) id <NGHowItWorksScreenControllerDelegate> delegate;

@end
