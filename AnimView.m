//
//  AnimView.m
//  ViewAnimTest
//
//  Created by Andrey Karaban on 29/10/15.
//  Copyright © 2015 Andrey Karaban. All rights reserved.
//

#import "AnimView.h"

#define FIXED_WIDTH 738.f

@implementation AnimView
{
    UITextView *textView;
    CGRect startRect;
    CGRect finishRect;
}

@synthesize currentController, delegate;

- (instancetype)initWithViewController:(NGCurrentController)controller
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:46.f/255.f green:4.f/255.f blue:94.f/255.f alpha:1.f];
        
        currentController = controller;
        
        NSString *str;
        
        switch (currentController) {
            case NGCurrentControllerChooseFrameController:
                str = @"NGCurrentControllerChooseFrameControllerNGCurrentControllerChooseFrameControllerNGCurrentControllerChooseFrameController";
                break;
            case NGCurrentControllerFramePsentationController:
            {
                str = @"NGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFramePsentationControllerNGCurrentControllerFrameP";
                NSLog(@"FTW");
            }
                break;
            case NGCurrentControllerGlassesType:
                str = @"NGCurrentControllerGlassesTypeNGCurrentControllerGlassesTypeNGCurrentControllerGlassesType";
                break;
            default:
                break;
        }
        
        textView = [UITextView new];
        
        
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setFont:[UIFont fontWithName:@"Trebuchet MS" size:18.f]];
        [textView setUserInteractionEnabled:NO];
        [textView setText:str];
        
        CGSize newSize = [textView sizeThatFits:CGSizeMake(FIXED_WIDTH, MAXFLOAT)];
        CGRect newFrame = textView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, FIXED_WIDTH), newSize.height);
        
        textView.frame = CGRectMake(15.f, 20.f, newFrame.size.width, newFrame.size.height);//newFrame;
        
        self.frame = CGRectMake(0.f, (-1) * (textView.frame.size.height + 40), textView.frame.size.width + 30, textView.frame.size.height + 40);
        
        [self addSubview:textView];
        
        startRect = self.frame;
        
        finishRect = CGRectMake(0.f, 0.f, textView.frame.size.width + 30, textView.frame.size.height + 40);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideFromTop)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)slideFromTop
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (CGRectEqualToRect(self.frame, startRect))
    {
        self.frame = finishRect;
    }
    else
    {
        self.frame = startRect;
        if (delegate && [delegate respondsToSelector:@selector(hideShow)]) {
            [delegate hideShow];
        }
    }
    [UIView commitAnimations];
}

@end
