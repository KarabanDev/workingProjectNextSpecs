//
//  NGGlassesOptionsViewController.m
//  NGKioskApp
//
//  Created by Work Inteleks on 6/25/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGGlassesOptionsViewController.h"

@interface NGGlassesOptionsViewController ()
{
    float modulePrice;
    NSMutableDictionary *dict;
    NSString *key;
    NSMutableArray *curAr;
}

@end

@implementation NGGlassesOptionsViewController
{
    NSMutableArray *selectedButtons;
}
@synthesize buttons;
@synthesize selectLabel;
@synthesize priceLabel;
@synthesize frameLabel;
@synthesize typeLabel;
@synthesize photochromicButtons;
@synthesize photochromicOptionsView;
@synthesize photochromicBtn;
@synthesize priceOfFrame;
@synthesize priceOfChoice, priceOfSecondChoice, priceOfThirdChoice, priceOfType;
@synthesize secondChoiceLabel, thirdChoice;
@synthesize optionsLabel;
@synthesize allPricesOfChoices;

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedButtons = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"at Option's Screen Cart Contains %d objects" ,[DATA_MANAGER.currentCart getAllItems].count);
    
    frameLabel.text = [[[DATA_MANAGER.currentCart getAllItems]objectAtIndex:0] nameItem];
    priceOfFrame.text = [NSString stringWithFormat:@"$%.2f", [[[DATA_MANAGER.currentCart getAllItems]objectAtIndex:0] priceItem]];
    
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
    
    for(id obj in [DATA_MANAGER.currentCart getAllItems])
    {
        if ([obj tipo] == NGItemTypeSingleVision || [obj tipo] == NGItemTypeProgressive)
        {
            selectLabel.text = [obj nameItem];
            selectLabel.hidden = NO;
            priceOfType.text = [NSString stringWithFormat:@"$%.2f", [obj priceItem]];
            priceOfType.hidden = NO;
        }
    }
    
    for(UIButton *btn in buttons)
        btn.selected = NO;
    
    dict = [NSMutableDictionary new];
    key = [NSString new];
    curAr = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectedBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    switch (sender.tag)
    {
        case 0:
            key = @"NGItemTypeHightIndex";
            break;
        case 1:
            key = @"NGItemTypeAntiReflective";
            break;
        case 2:
            key = @"NGItemTypePhotochromic";
            break;
        default:
            break;
    }
    
    if (sender.selected)
    {
        switch (sender.tag)
        {
            case 0:
              DATA_MANAGER.currentItem = [DATA_MANAGER createNewItemWithType:NGItemTypeHightIndex];
                 break;
                
            case 1:
                DATA_MANAGER.currentItem = [DATA_MANAGER createNewItemWithType:NGItemTypeAntiReflective];
                break;
                
            case 2:
                DATA_MANAGER.currentItem = [DATA_MANAGER createNewItemWithType:NGItemTypePhotochromic];

                for (UIButton *btn in photochromicButtons)
                    btn.selected = NO;
                
                photochromicOptionsView.hidden = NO;
                break;
        }
        
        [DATA_MANAGER.currentCart addItemToCart:DATA_MANAGER.currentItem];
        [dict setObject:DATA_MANAGER.currentItem forKey:key];
        [curAr addObject:key];
        
    }else{
        [[DATA_MANAGER.currentCart getAllItems] removeObject:[dict objectForKey:key]];
        [dict removeObjectForKey:key];
        [curAr removeObject:key];
    }
    

    [self makeVisibleIfExists];
     priceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
}

- (IBAction)photochromicOptions:(UIButton *)sender
{
    for (UIButton *btn in photochromicButtons)
        btn.selected = NO;
    
    sender.selected = !sender.selected;
}

- (IBAction)hidePhotochromicOptions:(UIButton *)sender
{
    for(UIButton *btn in photochromicButtons){
        if (btn.selected) {
            break;
        }else if (btn.tag == 1)
        {
            photochromicBtn.selected = YES;
            [self selectedBtn:photochromicBtn];
            break;
        }
     }
    photochromicOptionsView.hidden = YES;
}

- (void)addOptions:(NSString *)options
{
    selectLabel.text = [NSString stringWithFormat:@"%@", [DATA_MANAGER.optionsSunglasses objectForKey:@"options"]];
}

- (IBAction)backBtnPressed:(id)sender
{
   
    for(id obj in [[DATA_MANAGER.currentCart getAllItems] copy])
    {
        if ([obj tipo] == NGItemTypeHightIndex || [obj tipo] == NGItemTypeAntiReflective || [obj tipo] == NGItemTypePhotochromic)
        {
            [[DATA_MANAGER.currentCart getAllItems] removeObject:obj];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnPressed:(id)sender
{
    [self performSegueWithIdentifier:@"glassesInfo" sender:nil];
}

- (void)makeVisibleIfExists
{
    NSString *curK;
    
    switch ([dict count]) {
        case 0:
            typeLabel.text = @"Choose option you preffer";
            
            for(UILabel *lbl in allPricesOfChoices)
                lbl.hidden = YES;
            for(UILabel *lbl in optionsLabel)
                lbl.hidden = YES;
            break;
            
        case 1:
            for(UILabel *lbl in allPricesOfChoices)
                lbl.hidden = YES;
            for(UILabel *lbl in optionsLabel)
                lbl.hidden = YES;
            
            curK = [curAr objectAtIndex:0];
            typeLabel.text = [[dict objectForKey:curK]nameItem];
            priceOfChoice.text = [NSString stringWithFormat:@"$%.2f", [[dict objectForKey:curK] priceItem]];
            priceOfChoice.hidden = NO;
            break;
            
        case 2:
            curK = [curAr objectAtIndex:1];
            secondChoiceLabel.text = [[dict objectForKey:curK] nameItem];
            secondChoiceLabel.hidden = NO;
            priceOfSecondChoice.text = [NSString stringWithFormat:@"$%.2f", [[dict objectForKey:curK] priceItem]];
            priceOfSecondChoice.hidden = NO;
            thirdChoice.hidden = YES;
            priceOfThirdChoice.hidden = YES;
            break;
            
        case 3:
            curK = [curAr objectAtIndex:2];
             thirdChoice.text = [[dict objectForKey:curK] nameItem];
            thirdChoice.hidden = NO;
            priceOfThirdChoice.text = [NSString stringWithFormat:@"$%.2f", [[dict objectForKey:curK] priceItem]];
            priceOfThirdChoice.hidden = NO;
            break;
            
        default:
            break;
    }
}

@end
