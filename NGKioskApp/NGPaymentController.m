//
//  NGPaymentController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 13/07/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGPaymentController.h"
#import "NGDataManager.h"

@interface NGPaymentController ()

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

- (IBAction)enterCCPressed:(id)sender;
- (IBAction)swipePressed:(id)sender;
- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)confirmationPressed:(id)sender;

@end

@implementation NGPaymentController
@synthesize totalPriceLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    totalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enterCCPressed:(id)sender {
}

- (IBAction)swipePressed:(id)sender {
}

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)confirmationPressed:(id)sender
{
    [self performSegueWithIdentifier:@"toOrderScreen" sender:nil];
}
@end
