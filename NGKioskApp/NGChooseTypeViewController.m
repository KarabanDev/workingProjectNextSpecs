//
//  NGChooseTypeViewController.m
//  NGKioskApp
//
//  Created by Work Inteleks on 6/24/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGChooseTypeViewController.h"

@interface NGChooseTypeViewController ()
{
    float modulePrice;
}

@end

@implementation NGChooseTypeViewController

@synthesize buttons;
@synthesize selectLabel;
@synthesize priceLabel;
@synthesize frameLabel;
@synthesize lensesLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    modulePrice = DATA_MANAGER.priceSunglasses;
    
    frameLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"frame"];
    lensesLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"lenses"];
    
    [self addPrice:0.00];
    [self addOptions:@"none"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtnPressed:(id)sender
{
    DATA_MANAGER.priceSunglasses = modulePrice;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectedBtn:(UIButton *)sender
{
    for (UIButton *btn in buttons)
    {
        if (sender.tag == btn.tag)
        {
            if (btn.selected)
            {
                btn.selected = NO;
                [self addPrice:0.00];
                [self addOptions:@"none"];
            }
            else
            {
                btn.selected = YES;
//                [self addPrice:sender.tag ? priceProgresseve : priceSingleVision];
                [self addOptions:sender.tag ? @"Progresseve polarized" : @"Single Vision"];
            }
        }
        else
        {
            btn.selected = NO;
        }
    }
}

- (void)addPrice:(float)price
{
    if (DATA_MANAGER.priceSunglasses == modulePrice)
    {
        DATA_MANAGER.priceSunglasses += price;
    }
    else
    {
        DATA_MANAGER.priceSunglasses = modulePrice;
        DATA_MANAGER.priceSunglasses += price;
    }
    
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", DATA_MANAGER.priceSunglasses];
}

- (void)addOptions:(NSString *)options
{
    [DATA_MANAGER.optionsSunglasses setObject:options forKey:@"type"];
    
    selectLabel.text = [NSString stringWithFormat:@"%@", [DATA_MANAGER.optionsSunglasses objectForKey:@"type"]];
}

@end
