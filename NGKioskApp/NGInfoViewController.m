//
//  NGInfoViewController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 16/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGInfoViewController.h"
#import "NGDataManager.h"
#import "NSString+NGCheckStrings.h"

@interface NGInfoViewController()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *prescriptionConditonBtn;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *customerInfoTextFields;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)backPressed:(id)sender;
- (IBAction)nextBtnPressed:(id)sender;
- (IBAction)homeBtnPressed:(id)sender;

@end

@implementation NGInfoViewController

@synthesize prescriptionConditonBtn;
@synthesize customerInfoTextFields;
@synthesize nextButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     for(UIButton *button in prescriptionConditonBtn)
        [button addTarget:self action:@selector(prescriptionConditonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    for(UITextField *textField in customerInfoTextFields)
        textField.delegate = self;
    
    nextButton.enabled = NO;
  //  [self textChanged];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (void)prescriptionConditonBtnPressed:(UIButton *)sender
{
    for(UIButton *btn in prescriptionConditonBtn)
    {
        if (btn.selected)
            [btn setSelected:NO];
    }
    
    sender.selected=!sender.selected;
    
    DATA_MANAGER.currentChoice = [sender tag];
    
    nextButton.enabled = YES;
}

- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnPressed:(id)sender
{
   // [NGCustomer saveInUserDefaults:currentCustomer];

    [self performSegueWithIdentifier:@"toPrescriptionController" sender:nil];
}

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TextField Delagate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *key = [NSString new];
    
    if ([textField.text stringIsNotNil:textField.text] && [textField.text length] > 2)
    {
        switch (textField.tag)
        {
            case 0:
                key = @"customerName";
                break;
            case 1:
                key = @"customerLastName";
                break;
            case 2:
                 key = @"customerStreet";
                break;
            case 3:
                key = @"customerStreet";
                break;
            case 4:
                key = @"customerCity";
                break;
            case 5:
                key = @"customerState";
                break;
            case 6:
                key = @"customerZipCode";
                break;
            case 7:
                key = @"customerPhoneNumber";
                break;
            case 8:
                if ([textField.text validEmail:textField.text])
                    key = @"customerEmail";
                else
                    [textField.text showAlertWithMessage:@"Email address is not correct."];
                break;
            case 9:
                if (![textField.text checkIfString:[[NSUserDefaults standardUserDefaults] stringForKey:@"customerEmail"] isEqualTo:textField.text])
                    [textField.text showAlertWithMessage:@"Please check your email address and confirm it again."];
                break;
                

            default:
                break;
        }
        
        [DATA_MANAGER setData:textField.text forKey:key];
    }else{
        [textField.text showAlertWithMessage:@"Please, check your personal data!"];
    }
    //[self textChanged];
}

- (void)nextButtonWithStatus:(BOOL)status
{
    nextButton.enabled = !status;
}

- (void)textChanged
{
    for(UITextField *textField in customerInfoTextFields){
        [self nextButtonWithStatus:![textField.text stringIsNotNil:textField.text]];
    }
}

@end
