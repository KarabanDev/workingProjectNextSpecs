//
//  NGStartViewController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 26/10/15.
//  Copyright © 2015 ACEP. All rights reserved.
//

#import "NGStartViewController.h"
#import "NGHowItWorksScreenController.h"
#import "UIView+Effects.h"

@interface NGStartViewController ()<NGHowItWorksScreenControllerDelegate>

{
    NGHowItWorksScreenController *helpController;
}

- (IBAction)learnHowItWorksBtnPressed:(id)sender;

@end

@implementation NGStartViewController
{
    IBOutlet UIImageView *mainBgImage;
    IBOutlet UIImageView *logoImage;
    IBOutlet UILabel *mainScreenLabel;
    IBOutlet UIButton *learnHowItWorksBtn;
    IBOutlet UIButton *getStartedBtn;
}


#pragma mark - Lifecycle of controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainScreenLabel.text = NSLocalizedString(@"mainScreenLabel", @"");
    
    learnHowItWorksBtn.titleLabel.text = NSLocalizedString(@"Learn how it works", @"");
    getStartedBtn.titleLabel.text = NSLocalizedString(@"Get Started", @"");
    
    
}
- (IBAction)learnHowItWorksBtnPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (!helpController)
    {
        
        helpController = [storyboard instantiateViewControllerWithIdentifier:@"HowItWorksViewController"];
        helpController.delegate = self;
        [self.view addSubview:helpController.view];
        
        [helpController.view showInfoViewInPoint:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    }
}

- (void)removeController
{
    [helpController.view hideInfoViewWithAnimation];
    
    helpController = nil;

}

- (void)getStarted
{
    [self performSegueWithIdentifier:@"toMainScreen" sender:nil];
}

@end
