//
//  AnimView.h
//  ViewAnimTest
//
//  Created by Andrey Karaban on 29/10/15.
//  Copyright © 2015 Andrey Karaban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, NGCurrentController) {
    NGCurrentControllerChooseFrameController,
    NGCurrentControllerFramePsentationController,
    NGCurrentControllerGlassesType
};
@protocol AnimViewDelegate <NSObject>

- (void)hideShow;

@end

@interface AnimView : UIView

@property (nonatomic, assign) NGCurrentController currentController;
@property (nonatomic, assign) id <AnimViewDelegate> delegate;
- (instancetype)initWithViewController:(NGCurrentController)controller;


- (void)slideFromTop;

@end
