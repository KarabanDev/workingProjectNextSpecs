//
//  NGChooseOptionsViewController.m
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGChooseOptionsViewController.h"

@interface NGChooseOptionsViewController ()
{
    float modulePrice;
}

@end

@implementation NGChooseOptionsViewController

@synthesize buttons;
@synthesize selectLabel;
@synthesize priceLabel;
@synthesize frameLabel;
@synthesize lensesLabel;
@synthesize typeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    modulePrice = DATA_MANAGER.priceSunglasses;
    
    frameLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"frame"];
    lensesLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"lenses"];
    typeLabel.text = [DATA_MANAGER.optionsSunglasses objectForKey:@"type"];

    [self addPrice:0.00];
    [self addOptions:@"none"];
}

- (IBAction)backBtnPressed:(id)sender
{
    DATA_MANAGER.priceSunglasses = modulePrice;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
//                [self addPrice:sender.tag ? priceAntiReflective : priceHighIndex];
//                [self addOptions:sender.tag ? @"Anti Reflective" : @"High Index"];
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
    [DATA_MANAGER.optionsSunglasses setObject:options forKey:@"options"];
    
    selectLabel.text = [NSString stringWithFormat:@"%@", [DATA_MANAGER.optionsSunglasses objectForKey:@"options"]];
}

- (IBAction)nextBtnPressed:(id)sender
{
    [self performSegueWithIdentifier:@"sunglassesInfo" sender:nil];
}

@end
