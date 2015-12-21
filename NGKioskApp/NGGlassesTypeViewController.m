//
//  NGGlassesTypeViewController.m
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGGlassesTypeViewController.h"

@interface NGGlassesTypeViewController ()
{
    float modulePrice;
    NSMutableArray *itemsInCart;
}

@end

@implementation NGGlassesTypeViewController

@synthesize buttons;
@synthesize selectLabel;
@synthesize priceLabel;
@synthesize frameLabel;
@synthesize priceOfChoice;
@synthesize priceOfFrame;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(UIButton *btn in buttons)
        btn.selected = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    selectLabel.layer.borderWidth = 3.f;
    selectLabel.layer.borderColor = [[UIColor redColor] CGColor];
    frameLabel.layer.borderWidth = 3.f;
    frameLabel.layer.borderColor = [[UIColor colorWithRed:110.f/255.f green:101.f/255.f blue:102.f/255.f alpha:1.0] CGColor];
    
    priceOfFrame.text = [NSString stringWithFormat:@"$%.2f", [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] priceItem]];
    
    frameLabel.text = [NSString stringWithFormat:@"  %@", [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] nameItem]] ;
    
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
    
    NSLog(@"Cart contains %d objects", [DATA_MANAGER.currentCart getAllItems].count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectedBtn:(UIButton *)sender
{
    for(UIButton *btn in buttons)
    {
        if (btn.selected)
            [btn setSelected:NO];
    }
    sender.selected=!sender.selected;
    
    if ([sender tag])
        DATA_MANAGER.currentItem = [DATA_MANAGER createNewItemWithType:NGItemTypeProgressive];
    else
        DATA_MANAGER.currentItem = [DATA_MANAGER createNewItemWithType:NGItemTypeSingleVision];
    
    if([DATA_MANAGER.currentCart getAllItems].count > 1)
       [[DATA_MANAGER.currentCart getAllItems] replaceObjectAtIndex:1 withObject:DATA_MANAGER.currentItem];
    else
        [DATA_MANAGER.currentCart addItemToCart:DATA_MANAGER.currentItem];
   
    [self addOptions:sender.tag ? @"Progresseve polarized" : @"Single Vision"];
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
}


- (void)addOptions:(NSString *)options
{
    priceOfChoice.text = [NSString stringWithFormat:@"$%.2f", [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:1] priceItem]];
    selectLabel.text = [NSString stringWithFormat:@"  %@", options];
}

- (IBAction)backBtnPressed:(id)sender
{
    for(id obj in [[DATA_MANAGER.currentCart getAllItems] copy])
    {
        if ([obj tipo] == NGItemTypeProgressive || [obj tipo] == NGItemTypeSingleVision)
        {
            [[DATA_MANAGER.currentCart getAllItems] removeObject:obj];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
