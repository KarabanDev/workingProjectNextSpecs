//
//  NGHelpScreenController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 26/10/15.
//  Copyright © 2015 ACEP. All rights reserved.
//

#import "NGHowItWorksScreenController.h"

@interface NGHowItWorksScreenController ()

- (IBAction)removeScreen:(id)sender;

- (IBAction)getStarted:(id)sender;

@end

@implementation NGHowItWorksScreenController
{
    IBOutlet UIView *backgroundView;
    
    IBOutlet UIImageView *mainBG;
    IBOutlet UIImageView *logoImage;
    IBOutlet UILabel *howItWorks;
    
    IBOutlet UILabel *explainationTextForHelpScreen;
    
    IBOutlet UILabel *firstBulletpoint;
    IBOutlet UILabel *secondBulletpoint;
    IBOutlet UILabel *thirdBulletpoint;
    
    IBOutlet UIButton *goBackBtn;
    IBOutlet UIButton *getStartedBtn;
}

@synthesize delegate;

const float WINDOW_WIDTH = 768.f;
const float WINDOW_HEIGHT = 1024.f;
const float WINDOW_CORNER_RADIUS = 20.f;

#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backgroundView.layer.cornerRadius = WINDOW_CORNER_RADIUS;
    self.view.layer.cornerRadius = WINDOW_CORNER_RADIUS;
    
    [self.view setFrame:CGRectMake(0.f, 0.f, WINDOW_WIDTH, WINDOW_HEIGHT)];
    
    howItWorks.text = NSLocalizedString(@"How it works", @"");
    
    explainationTextForHelpScreen.text = NSLocalizedString(@"Explaination", @"");
    
    firstBulletpoint.text = NSLocalizedString(@"FirstBulletpoint", @"");
    secondBulletpoint.text = NSLocalizedString(@"SecondBulletpoint", @"");
    thirdBulletpoint.text = NSLocalizedString(@"ThirdBulletpoint", @"");
    
    goBackBtn.titleLabel.text = NSLocalizedString(@"Back Home", @"");
    getStartedBtn.titleLabel.text = NSLocalizedString(@"Get Started", @"");
}

- (void)removeScreen:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(removeController)])
        [delegate removeController];
}

- (void)getStarted:(id)sender
{
    if(delegate && [delegate respondsToSelector:@selector(getStarted)])
        [delegate getStarted];
}
@end
