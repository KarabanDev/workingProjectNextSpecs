//
//  NGNavigationController.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGNavigationController.h"

@interface NGNavigationController ()

@end

@implementation NGNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:44.f/255.f green:4.f/255.f blue:94.f/255.f alpha:1.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Autorotate

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidLayoutSubviews
{
}

@end
