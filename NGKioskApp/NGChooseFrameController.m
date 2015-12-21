//
//  NGChooseFrameController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 11/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGChooseFrameController.h"
#import "NGCamera.h"
#import "NGSQLiteDataBaseManager.h"
#import "NGFrame.h"
#import "NGDataManager.h"
#import "AnimView.h"

@interface NGChooseFrameController ()<NGCameraDelegate, UIAlertViewDelegate, UITextFieldDelegate, AnimViewDelegate>
{
    NGCamera *camera;
    NGDataManager *dataManager;
}
//@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UITextView *startTextView;
@property (weak, nonatomic) IBOutlet UIView *cameraContainer;
@property (weak, nonatomic) IBOutlet UIView *cameraPreview;

- (IBAction)cameraPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;

@end

@implementation NGChooseFrameController
{
    BOOL shouldHideStatusBar;
}
@synthesize cameraButton, startTextView, cameraContainer, cameraPreview;

#pragma mark - Controller lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;
    
    shouldHideStatusBar = NO;
}
- (BOOL)prefersStatusBarHidden
{
    return shouldHideStatusBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIImageView *barImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"questionMark"]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfoView)];
    [barImage addGestureRecognizer:tapGesture];
    UIBarButtonItem *questionMark = [[UIBarButtonItem alloc] initWithCustomView:barImage];
    [self.navigationItem setRightBarButtonItem:questionMark];
    
    self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationItemLogo"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IB Actions

- (IBAction)cameraPressed:(id)sender
{
    [self loadCamera];
}

- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CameraDelegate

- (void)loadCamera
{
    camera = [[NGCamera alloc] initWithFront:NO];
    camera.delegate = self;
    
    [camera setPreviewContainer:cameraPreview];
    
    startTextView.hidden = YES;
    cameraButton.hidden = YES;
}

- (void)foundScanCodes:(NSArray *)codes
{
    [DATA_MANAGER setCurrentBarCode:[codes objectAtIndex:0]];
    [DATA_MANAGER createNewItemWithType:NGItemTypeFrame];
    
    if (DATA_MANAGER.currentItem.frame == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                message:@"There is no such frame in our DataBase. Please scan again or search with other criteria."
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:/*@"Search",*/ nil];
        
//        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//        [alert textFieldAtIndex:0].delegate = self;
        
        [alert show];
        
    }else
    {
        [DATA_MANAGER checkIfCartWithItemsContainsFrame:DATA_MANAGER.currentItem];
        [self goToNextScreen];
    }
    
    [camera stopCamera];
    camera.delegate = nil;
    [camera setPreviewContainer:nil];
    camera = nil;
    startTextView.hidden = NO;
    cameraButton.hidden = NO;

}

- (void)goToNextScreen
{
    [self performSegueWithIdentifier:@"toFrameDemonstration" sender:nil];
}

#pragma mark - Alert View Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
       //[DB_MANAGER getFramesByParameter:[alertView textFieldAtIndex:0].text];
        
      //  NSLog(@"ALL FRAMES - %@", [DB_MANAGER getAllFrames]);
        
        NSLog(@"GGGGGG - %@",[DB_MANAGER getFramesByParameter:[alertView textFieldAtIndex:0].text]);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    return  ([[[alertView textFieldAtIndex:0] text] length] > 0)? YES:NO;
}

- (void)showInfoView
{
    self.navigationController.navigationBarHidden = YES;
    
    AnimView *av = [[AnimView alloc] initWithViewController:NGCurrentControllerChooseFrameController];
    av.delegate = self;
    [self.view addSubview:av];
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

@end
