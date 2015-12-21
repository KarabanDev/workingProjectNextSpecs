//
//  NGCartInfoController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 22/06/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGCartInfoController.h"
#import "NGPreordercell.h"
#import "NGDataManager.h"
#import "UIImage+NGUIResizedImage.h"

@interface NGCartInfoController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *sourceTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

-(IBAction)showDetail:(id)sender;
- (IBAction)nextBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)addBtnPressed:(id)sender;
- (IBAction)homeBtnPressed:(id)sender;

@end

@implementation NGCartInfoController
{
    NGPreorderCell *cell;
    NSMutableArray *cartItems;
    int frameCounts;
    NSIndexPath *path;
    int itemsCount;
}

@synthesize sourceTableView;
@synthesize totalPriceLabel;

#pragma mark - Controller Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sourceTableView.delegate = self;
    sourceTableView.dataSource = self;
    sourceTableView.layer.borderWidth = 2.f;
    sourceTableView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    sourceTableView.allowsSelection = NO;
    
    cartItems = [DATA_MANAGER.currentCart getAllItems];
 }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    totalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
    frameCounts = 1;
    itemsCount = [DATA_MANAGER.currentCart getAllItems].count;
    NSLog(@"Cart contains %d number of items\n\n", cartItems.count);
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

#pragma mark - TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *img;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"PreorderCell"];
    
    if ([[cartItems objectAtIndex:indexPath.row] tipo] != NGItemTypeFrame)
    {
        cell.removeBtn.hidden = YES;
        cell.plusBtn.hidden = YES;
        cell.minusBtn.hidden = YES;
        cell.quantityLabel.hidden = YES;
        cell.brendLabel.hidden = YES;
    }else{
        cell.removeBtn.hidden = NO;
        cell.plusBtn.hidden = NO;
        cell.minusBtn.hidden = NO;
        cell.quantityLabel.text = [NSString stringWithFormat:@"%d", frameCounts];
        cell.quantityLabel.hidden = NO;
        cell.brendLabel.hidden = NO;
    }
    
    if ([[cartItems objectAtIndex:indexPath.row] imageName] != nil)
        img = [UIImage imageNamed:[[cartItems objectAtIndex:indexPath.row] imageName]];
    
    cell.frameImage.image = [UIImage imageWithImage:img scaledToSize:CGSizeMake(200.f, 230.f)];
    cell.nameOfItem.text = [[cartItems objectAtIndex:indexPath.row] nameItem];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%.2f",[[cartItems objectAtIndex:indexPath.row] priceItem]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Number of items -%d\n",[DATA_MANAGER.currentCart getAllItems].count);
    return itemsCount;
}


//Sometimes it's handy to use your own buttons inside a table view cell, and have a separate IBAction method to handle button presses (instead of the table's didSelectRowAtIndexPath method, which handles row presses). In order to figure out which row contains the button pressed, you can use the following code to find the parent cell:
//
-(NGPreorderCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (NGPreorderCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}
//Then in your button handler method, call the above method to get the parent cell, and then the table view's indexPathForCell: to get the indexPath. (This assumes you have a @property defined for the table view; in this case the property name is theTableView. For simple tables you can also use cell.superview to get the table view object.)
//
-(IBAction)showDetail:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NGPreorderCell *cel = [self parentCellForView:btn];
    if (cel != nil) {
        path = [sourceTableView indexPathForCell:cel];
        
        switch (btn.tag) {
            case 0:
                NSLog(@"changePressed");
                break;
            case 1:
            {
                NSLog(@"removePressed");
                [cartItems removeObjectAtIndex:path.row];
                [sourceTableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
                [sourceTableView reloadData];
            }
                break;
            case 2:
            {
                NSLog(@"plusPressed");
                
//                [cartItems addObject:[cartItems objectAtIndex:0]];
//                
//                frameCounts++;
//                
//                cell.quantityLabel.text = [NSString stringWithFormat:@"%d", frameCounts];
//                cell.priceLabel.text =[ NSString stringWithFormat:@"$%.2f", NG_FRAME_PRICE * frameCounts];
//                [self reloadTopCell];
              }
                break;
            case 3:
                
                if ([[cartItems lastObject] tipo] == NGItemTypeFrame)
                {
                    
                    if (frameCounts == 1)
                    {
                        return;
                    }else{
//                        [cartItems removeObject:[cartItems lastObject]];
//                        frameCounts--;
//                        cell.quantityLabel.text = [NSString stringWithFormat:@"%d", frameCounts];
//                        cell.priceLabel.text =[ NSString stringWithFormat:@"$%.2f", NG_FRAME_PRICE * frameCounts];
//                        [self reloadTopCell];
                    }
                 }
                break;
                
            default:
                break;
        }
    }
    totalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
}

- (IBAction)nextBtnPressed:(id)sender
{
    [self performSegueWithIdentifier:@"toPaymentScreen" sender:nil];
}

- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addBtnPressed:(id)sender
{
    NSLog(@"LOGIC TO ADD SOME ITEM!\n");
}

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadTopCell
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [sourceTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    });
}

@end
