//
//  NGChooseLensesViewController.m
//  NGKioskApp
//
//  Created by Work Inteleks on 6/24/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGChooseLensesViewController.h"
#import "NGChooseTypeViewController.h"

@interface NGChooseLensesViewController ()
{
    float modulePrice;
}

@end

@implementation NGChooseLensesViewController

@synthesize buttons;
@synthesize selectLabel;
@synthesize priceLabel;
@synthesize frameLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    DATA_MANAGER.priceSunglasses = NG_FRAME_PRICE;
    modulePrice = DATA_MANAGER.priceSunglasses;
    
    [DATA_MANAGER.optionsSunglasses setObject:@"Frame" forKey:@"frame"];
    frameLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"frame"];
    
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
                [self addPrice:sender.tag ? NG_POLARIZED_PRICE : NG_PHOTOCHROMIC_PRICE];
                [self addOptions:sender.tag ? @"Brown Lenses" : @"Grey Lenses"];
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
    [DATA_MANAGER.optionsSunglasses setObject:options forKey:@"lenses"];
    
    selectLabel.text = [NSString stringWithFormat:@"%@", [DATA_MANAGER.optionsSunglasses objectForKey:@"lenses"]];
}

@end
