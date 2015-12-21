//
//  NGFramePresentationController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 11/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGFramePresentationController.h"
#import "NGDataManager.h"
#import "NGFrame.h"
#import "AnimView.h"

@interface NGFramePresentationController ()<AnimViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *frameImage;
@property (weak, nonatomic) IBOutlet UILabel *nameOfFrameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfFrame;
@property (weak, nonatomic) IBOutlet UITextView *descriptionOfFrame;

- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)nextBtnPressed:(id)sender;

@end

@implementation NGFramePresentationController
{
    AnimView *av;
    BOOL shouldHideStatusBar;
    NSTimer *slideTimer;
    NSMutableArray *arrayOfImages;
    int loopCount;
    CGRect startRect;
    UIBarButtonItem *questionMark;
}

@synthesize descriptionOfFrame, frameImage, nameOfFrameLabel, priceOfFrame;

- (BOOL)prefersStatusBarHidden
{
    return shouldHideStatusBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        av = [[AnimView alloc] initWithViewController:NGCurrentControllerFramePsentationController];
        av.delegate = self;
        [self.view addSubview:av];

    nameOfFrameLabel.text = [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] nameItem];

    //frameImage.image = [UIImage imageNamed:[[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] imageName]];
    
    priceOfFrame.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
    
    descriptionOfFrame.text = [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] productDescription];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIImageView *barImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"questionMark"]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfoView)];
    [barImage addGestureRecognizer:tapGesture];
    questionMark = [[UIBarButtonItem alloc] initWithCustomView:barImage];
    [self.navigationItem setRightBarButtonItem:questionMark];
    
    [[[UINavigationBar appearance] backItem] setTitle:NSLocalizedString(@"Re-scan",@"")];
    self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationItemLogo"]];
    shouldHideStatusBar = NO;
    
    arrayOfImages = [[NSMutableArray alloc] initWithObjects:@"framesImg0.jpg",@"framesImg1.jpg",@"framesImg2.jpg", nil];
    loopCount = 0;
    frameImage.image = [UIImage imageNamed:[arrayOfImages objectAtIndex:loopCount]];
    
    frameImage.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeImageGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    swipeImageGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeImageGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    swipeImageGestureRight.direction = UISwipeGestureRecognizerDirectionRight;

    [frameImage addGestureRecognizer:swipeImageGestureLeft];
    [frameImage addGestureRecognizer:swipeImageGestureRight];
    
    startRect = frameImage.frame;
    
    [self startTimerForSlideShow];
    
    NSLog(@"Count items inside the cart - %d", [DATA_MANAGER.currentCart getAllItems].count);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnPressed:(id)sender
{
    switch (DATA_MANAGER.currentScenario)
    {
        case NGScenarioTypeGlasses:
            [self performSegueWithIdentifier:@"glassesTypeController" sender:nil];
            break;
        case NGScenarioTypeSunglasses:
            [self performSegueWithIdentifier:@"chooseLensesController" sender:nil];
            break;
    }
}

- (void)showInfoView
{
    self.navigationController.navigationBarHidden = YES;
    
    shouldHideStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [av slideFromTop];
}

- (void)hideShow
{
    self.navigationController.navigationBarHidden = NO;
    shouldHideStatusBar = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) startTimerForSlideShow
{
    slideTimer = [NSTimer scheduledTimerWithTimeInterval:4.f
                                                  target:self
                                                selector:@selector(shouldChangeImages)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void) stopTimer
{
    [slideTimer invalidate];
    slideTimer = nil;
}

- (void)shouldChangeImages
{
    loopCount ++;
    
    if (loopCount >= [arrayOfImages count])
        loopCount = 0;
    
    [UIView animateWithDuration:1.f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        
        frameImage.frame = CGRectMake(frameImage.frame.origin.x - 800, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
        frameImage.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        frameImage.image = [UIImage imageNamed:[arrayOfImages objectAtIndex:loopCount]];
        frameImage.frame = CGRectMake(frameImage.frame.origin.x +1200, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
        
        [UIView animateWithDuration:1.f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            frameImage.alpha = 1.f;
            frameImage.frame = startRect;
        } completion:nil];
    }];
}

- (void)swipeImage:(UISwipeGestureRecognizer *)recognizer
{
    [self stopTimer];
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        loopCount --;
        if (loopCount <0)
            loopCount = [arrayOfImages count] - 1;
            
        [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            frameImage.frame = CGRectMake(frameImage.frame.origin.x - 800, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
            frameImage.alpha = 0.f;
        } completion:^(BOOL finished) {
            frameImage.image = [UIImage imageNamed:[arrayOfImages objectAtIndex:loopCount]];
            frameImage.frame = CGRectMake(frameImage.frame.origin.x + 1200, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                frameImage.alpha = 1.f;
                frameImage.frame = startRect;
            } completion:^(BOOL finished){
                 [self startTimerForSlideShow];
            }];
        }];
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        loopCount ++;
        if(loopCount>= [arrayOfImages count])
            loopCount = 0;
        
        [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            frameImage.frame = CGRectMake(frameImage.frame.origin.x + 800, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
            frameImage.alpha = 0.f;
        } completion:^(BOOL finished) {
            frameImage.image = [UIImage imageNamed:[arrayOfImages objectAtIndex:loopCount]];
            frameImage.frame = CGRectMake(frameImage.frame.origin.x - 1200, frameImage.frame.origin.y, frameImage.frame.size.width, frameImage.frame.size.height);
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                frameImage.alpha = 1.f;
                frameImage.frame = startRect;
            } completion:^(BOOL finished){
                [self startTimerForSlideShow];
            }];
        }];
    }
}

@end
