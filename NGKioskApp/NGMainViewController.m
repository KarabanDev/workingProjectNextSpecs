//
//  ViewController.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGMainViewController.h"
#import "NGDataManager.h"

@interface NGMainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *eyeGlassesBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunGlassesBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

- (IBAction)selectScenario:(UIButton *)sender;
- (IBAction)goToFrameSelectionPressed:(id)sender;

@end

@implementation NGMainViewController
{
    __weak IBOutlet UILabel *welcomeLabel;
    __weak IBOutlet UILabel *orderLabel;
    __weak IBOutlet UILabel *chooseTypeLabel;
    __weak IBOutlet UILabel *seeHowYouLookLabel;
    
    __weak IBOutlet UIButton *goToFrameSelectionBtn;
}
@synthesize buttons, eyeGlassesBtn, sunGlassesBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(UIButton *btn in buttons){
        btn.layer.cornerRadius = 15.f;
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.layer.borderColor = [[UIColor colorWithRed:3.f/255.f green:46.f/255.f blue:44.f/255.f alpha:1.f] CGColor];
        btn.layer.borderWidth = 1.f;
    }
    
    [eyeGlassesBtn setTitle:NSLocalizedString(@"Eye\nGlasses", @"") forState:UIControlStateNormal];
    [eyeGlassesBtn setTitle:NSLocalizedString(@"Eye\nGlasses", @"") forState:UIControlStateHighlighted];
    [eyeGlassesBtn setTitle:NSLocalizedString(@"Eye\nGlasses", @"") forState:UIControlStateSelected];
    
    [sunGlassesBtn setTitle:NSLocalizedString(@"Sun\nGlasses", @"") forState:UIControlStateNormal];
    [sunGlassesBtn setTitle:NSLocalizedString(@"Sun\nGlasses", @"") forState:UIControlStateHighlighted];
    [sunGlassesBtn setTitle:NSLocalizedString(@"Sun\nGlasses", @"") forState:UIControlStateSelected];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Smart Mirror", @"")];
    
    [attributedTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,[attributedTitle length])];
    
    [goToFrameSelectionBtn setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [goToFrameSelectionBtn setAttributedTitle:attributedTitle forState:UIControlStateHighlighted];
    [goToFrameSelectionBtn setAttributedTitle:attributedTitle forState:UIControlStateSelected];
    
    welcomeLabel.text = NSLocalizedString(@"Welcome", @"");
    orderLabel.text = NSLocalizedString(@"Order prescription Eyeglasses in just 5 minutes", @"");
    chooseTypeLabel.text = NSLocalizedString(@"What type of glasses do you like?", @"");
    seeHowYouLookLabel.text = NSLocalizedString(@"See how you look in our fashion frames by using our", @"");
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (void)selectScenario:(UIButton *)sender
{
    DATA_MANAGER.currentScenario = (NGScenarioType)sender.tag;
    
    switch (DATA_MANAGER.currentScenario) {
        case NGScenarioTypeGlasses:
            [self performSegueWithIdentifier:@"toChooseFrame" sender:nil];
            break;
        case NGScenarioTypeSunglasses:
            [self performSegueWithIdentifier:@"toChooseFrame" sender:nil];
            break;
    }
}

- (IBAction)goToFrameSelectionPressed:(id)sender
{
    [self performSegueWithIdentifier:@"toFrameSelection" sender:nil];
}

@end
