//
//  NGPrescriptionController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 16/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGPrescriptionController.h"
#import "NGCamera.h"
#import "NGDataManager.h"
#import "NSString+NGCheckStrings.h"
#import "NGDoctorInfo.h"

@interface NGPrescriptionController ()<UITextFieldDelegate>
{
    NGCamera *camera;
}
//--------------------- CAMERA VIEW ----------------------------
@property (weak, nonatomic) IBOutlet UIView *mainCameraView;
@property (weak, nonatomic) IBOutlet UIView *cameraContainerView;
@property (weak, nonatomic) IBOutlet UIView *cameraPreview;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;


- (IBAction)backBtnPressed:(id)sender;
- (IBAction)cameraBtnPressed:(id)sender;
- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)nextBtnPressed:(id)sender;

- (IBAction)takePhotoPressed:(id)sender;
//----------------------------------------------------------------


//--------------------- SEND EMAIL REQUEST VIEW ----------------------------

@property (weak, nonatomic) IBOutlet UIView *sendEmailRequestView;

//----------------------------------------------------------------


//--------------------- DOCTOR INFO VIEW ----------------------------

@property (weak, nonatomic) IBOutlet UIView *doctorInfoView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *doctorInfoDataTF;


//---------------------------------------------------------------------------

@end


@implementation NGPrescriptionController

@synthesize cameraContainerView, cameraPreview, mainCameraView;
@synthesize sendEmailRequestView;
@synthesize doctorInfoView, doctorInfoDataTF;

#pragma mark - Controller Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(UITextField *infoField in doctorInfoDataTF)
        infoField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch ([DATA_MANAGER currentChoice])
    {
        case 0:
            mainCameraView.hidden = NO;
            break;
        case 1:
            sendEmailRequestView.hidden = NO;
            break;
        case 2:
            doctorInfoView.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions of buttons

- (IBAction)cameraBtnPressed:(id)sender
{
    camera = [[NGCamera alloc] initWithFront:NO];
    [camera setPreviewContainer:cameraPreview];
    
    cameraContainerView.hidden = NO;
    _photoBtn.hidden = NO;
}

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextBtnPressed:(id)sender
{
    [NGDoctorInfo saveInUserDefaults:DATA_MANAGER.doctor];
    [self goToCartInfoController];
}


- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takePhotoPressed:(id)sender
{
    [camera takePhoto:^(BOOL success, UIImage *image){
        
        if (success)
        {
            [self performSelector:@selector(goToCartInfoController) withObject:nil afterDelay:1.f];
        }
    }];
}

- (void)goToCartInfoController
{
    [self performSegueWithIdentifier:@"toCartInfoController" sender:nil];
}

#pragma mark - TextFields delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *key = [NSString new];
    
    if ([textField.text stringIsNotNil:textField.text] && [textField.text length] > 2)
    {
        switch (textField.tag)
        {
            case 0:
                key = @"doctorName";
                break;
            case 1:
                key = @"doctorOfficeAddress";
                break;
            case 2:
                key = @"doctorCity";
                break;
            case 3:
                key = @"doctorState";
                break;
            case 4:
                key = @"doctorZip";
                break;
            case 5:
                key = @"doctorPhone";
                break;
            case 6:
                
            default:
                break;
        }
        
        [DATA_MANAGER setData:textField.text forKey:key];
    }else{
        [textField.text showAlertWithMessage:@"Please, check inserted data!"];
    }
}


@end
