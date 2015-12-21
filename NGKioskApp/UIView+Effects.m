//
//  UIView+Animate.m
//  SMTest
//
//  Created by Oleg Bogatenko on 6/26/14.
//

#import "UIView+Effects.h"
//#import "POP.h"

@implementation UIView (Effects)

//- (void)slideAnimateToPosition:(CGPoint)point
//{
//    [self activeView:NO];
//    
//    POPSpringAnimation *slide = [POPSpringAnimation animation];
//    
//    slide.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    slide.toValue = [NSValue valueWithCGRect:CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height)];
//    
//    slide.springBounciness = 3.f;
//    slide.springSpeed = 10.f;
//    
//    [self pop_addAnimation:slide forKey:@"slide"];
//    
//    [self performSelector:@selector(unlockView) withObject:nil afterDelay:0.3f];
//}
//
//- (void)scaleAnimation
//{
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    
//    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(2.f, 2.f)];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    scaleAnimation.springBounciness = 20.0f;
//    
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
//}
//
//- (void)addParalaxEffect
//{
//    UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
//    
//    interpolationHorizontal.minimumRelativeValue = @(-100.f);
//    interpolationHorizontal.maximumRelativeValue = @(100.f);
//    
//    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
//    
//    interpolationVertical.minimumRelativeValue = @(-50);
//    interpolationVertical.maximumRelativeValue = @(50);
//    
//    UIMotionEffectGroup *groupEffects = [UIMotionEffectGroup new];
//    groupEffects.motionEffects = @[interpolationHorizontal, interpolationVertical];
//    
//    [self addMotionEffect:groupEffects];
//}
//
//- (void)flipView
//{
//    float time = 0.4f;
//    
//    [self activeView:NO];
//    
//    [UIView animateWithDuration:time delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^(void) {
//                         self.transform = CGAffineTransformMakeScale(1, 1);
//                     }
//                     completion:nil];
//    
//    [self performSelector:@selector(unlockView) withObject:nil afterDelay:time];
//}
//
//- (void)closeFlipView
//{
//    float time = 0.3f;
//    
//    [self activeView:NO];
//    
//    [UIView animateWithDuration:time delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^(void) {
//                         
//                         // Xcode 6 bug - if firts value = 0 animation is not work
//                         self.transform = CGAffineTransformMakeScale(0.001, 0.5);
//                     }
//                     completion:nil];
//    
//    [self performSelector:@selector(unlockView) withObject:nil afterDelay:time];
//}
//
//- (void)cubeLikeAnimation
//{
//    self.alpha = 1.f;
//    
//    CATransition *transtion = [CATransition animation];
//    transtion.duration = 0.5f;
//    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//    [transtion setType:@"cube"];
//    [transtion setSubtype:kCATransitionFromRight];
//    [self.layer addAnimation:transtion forKey:@"transtionKey"];
//}

- (void)showInfoViewInPoint:(CGPoint)point
{
    self.alpha = 0.0;
    self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
    self.center = point;
    
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0f;
        self.center = point;
        self.transform = CGAffineTransformScale(self.transform, 100.f, 100.f);
        
    } completion:nil];
}

- (void)hideInfoViewWithAnimation
{
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
        self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)fadeView:(BOOL)fade
{
    if (!fade)
        self.hidden = NO;
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = (fade ? 0 : 1.0);
    } completion:^(BOOL finished) {
        self.hidden = fade;
    }];
}
//
//#pragma mark Block View When Animated
//
//- (void)unlockView
//{
//    [self activeView:YES];
//}
//
//- (void)activeView:(BOOL)lock
//{
//    self.userInteractionEnabled = lock;
//}
//
//#pragma mark Frame Selection Animated
//
//- (void)showSwipeAnimation
//{
//    POPSpringAnimation *anim = [POPSpringAnimation animation];
//    
//    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    anim.toValue = [NSValue valueWithCGRect:CGRectMake(954.0, 40.0, self.frame.size.width, self.frame.size.height)];
//    anim.springBounciness = 10.f;
//    anim.springSpeed = 10.f;
//    
//    [self pop_addAnimation:anim forKey:@"spirngAnim"];
//}
//
//- (void)hideSwipeAnimation
//{
//    POPSpringAnimation *anim = [POPSpringAnimation animation];
//    
//    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    anim.toValue = [NSValue valueWithCGRect:CGRectMake(1024, 40.0, self.frame.size.width, self.frame.size.height)];
//    anim.springBounciness = 10.f;
//    anim.springSpeed = 10.f;
//    
//    [self pop_addAnimation:anim forKey:@"spirngAnim"];
//}
//
//- (void)slideViewWithAnimationToPoint:(CGPoint)point
//{
//    self.alpha = 0.0;
//    
//    self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
//    
//    self.center = CGPointMake(512.f, 768.f + self.frame.size.height / 2);
//    
//    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 1.0f;
//        self.center = point;
//        self.transform = CGAffineTransformScale(self.transform, 100.f, 100.f);
//        
//    } completion:nil];
//}
//
//- (void)hideViewWithAnimation
//{
//    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 0.0f;
//        self.center = CGPointMake(512.f, 768.f + self.frame.size.height / 2);
//        self.transform = CGAffineTransformScale(self.transform, 0.01f, 0.01f);
//        
//    } completion:nil];
//}

@end
