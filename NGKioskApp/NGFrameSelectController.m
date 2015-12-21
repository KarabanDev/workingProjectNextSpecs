//
//  NGFrameSelectController.m
//  NGKioskApp
//
//  Created by Oleg Bogatenko on 6/2/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGFrameSelectController.h"
#import "NGCamera.h"
#import "NGPhotoCell.h"

@interface NGFrameSelectController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
{
    NGCamera *camera;
    
    __weak IBOutlet UICollectionView *photoPreview;
    
    __weak IBOutlet UIButton *scrollForwardBtn;
    __weak IBOutlet UIButton *scrollBackBtn;

    IBOutlet UIView *cameraPreview;
    
    __weak IBOutlet UIView *containerView;
    
    __weak IBOutlet UIScrollView *photoScrollView;
    
    
    NSMutableArray *photos;
    
    NGPhotoCell *photoCell;
    
    NSMutableArray *selectedItems;
    
    IBOutlet UIView *previewViewContainer;
    IBOutletCollection(UIImageView) NSArray *bigPreviewImages;
}

- (IBAction)homePressed:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)delete:(id)sender;
- (IBAction)comparePressed:(id)sender;

@end

@implementation NGFrameSelectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCamera];
    
    photos = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 4; ++i)
    {
        [photos addObject:[NSNull null]];
    }
    
    selectedItems = [photos mutableCopy];
    
    photoScrollView.delegate = self;
    
    [scrollForwardBtn addTarget:self action:@selector(scrollForward) forControlEvents:UIControlEventTouchUpInside];
    [scrollBackBtn addTarget:self action:@selector(scrollBack) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadCamera
{
    camera = [[NGCamera alloc] initWithFront:YES];
    
    [camera setPreviewContainer:cameraPreview];
}

#pragma mark - Actions

- (void)homePressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)takePhoto:(UIButton *)sender
{
    if (containerView.hidden) {
        [containerView setHidden:NO];
        [photoScrollView setHidden:YES];
        previewViewContainer.hidden = YES;
        return;
    }
    [camera takePhoto:^(BOOL success, UIImage *image){
        
        if (success)
        {
            for (int i = 0; i < photos.count; i++)
            {
                if ([[photos[i] class] isSubclassOfClass:[NSNull class]])
                {
                    [photos replaceObjectAtIndex:i withObject:image];
                        
                    break;
                }
            }
        }
        [photoPreview reloadData];
    }];
}

- (IBAction)delete:(id)sender
{
    for (int i=0; i <= [selectedItems count] - 1; i++)
    {
        if (![[selectedItems objectAtIndex:i] isKindOfClass:[NSNull class]])
        {
            [photos replaceObjectAtIndex:i withObject:[NSNull null]];
            [selectedItems replaceObjectAtIndex:i withObject:[NSNull null]];
        }
    }
    [photoPreview reloadData];
    
    photoScrollView.hidden = YES;
    previewViewContainer.hidden = YES;
    previewViewContainer.hidden = YES;

    containerView.hidden = NO;
}

- (IBAction)comparePressed:(id)sender
{
     for (int i = 0; i< [photos count]; i++)
    {

        if (![[photos objectAtIndex:i] isKindOfClass:[NSNull class]]) {
            UIImageView *image = bigPreviewImages [ i ];
             image.image = photos[ i ];
        }else{
            UIImageView *image = bigPreviewImages [ i ];
            image.image = nil;
        }
    }
    containerView.hidden = YES;
    photoScrollView.hidden = YES;
    
    previewViewContainer.hidden = NO;
    [previewViewContainer reloadInputViews];
}

- (void)scrollForward
{
    if (photoScrollView.contentOffset.x < 2304)
        [photoScrollView scrollRectToVisible:CGRectMake(photoScrollView.contentOffset.x + 768.f, 0.f, photoScrollView.frame.size.width, photoScrollView.frame.size.height) animated:YES];
}

- (void)scrollBack
{
    if (photoScrollView.contentOffset.x != 0.f)
        [photoScrollView scrollRectToVisible:CGRectMake(photoScrollView.contentOffset.x - 768.f, 0.f, photoScrollView.frame.size.width, photoScrollView.frame.size.height) animated:YES];
}

#pragma mark - Controller Rotate

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [camera.videoPreviewLayer.connection setVideoOrientation:(AVCaptureVideoOrientation)[UIDevice currentDevice].orientation];
}

#pragma mark - CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    if (![[photos objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]])
    {
        photoCell.ibThumbNailImage.image = [photos objectAtIndex:indexPath.row];
        photoCell.userInteractionEnabled = YES;
    }else
    {
        photoCell.ibThumbNailImage.image = nil;
        photoCell.userInteractionEnabled = NO;
    }
    
    photoCell.layer.borderWidth = 1.f;

    photoCell.layer.borderColor = [[UIColor yellowColor] CGColor];
 
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [selectedItems replaceObjectAtIndex:indexPath.row withObject:[photos objectAtIndex:indexPath.row]];
    [self showSelectedPhotoes];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [selectedItems replaceObjectAtIndex:indexPath.row withObject:[NSNull null]];
}


#pragma mark - 
- (void)showSelectedPhotoes
{
    containerView.hidden = YES;
    previewViewContainer.hidden = YES;
    
    int numberOfImages = (int)[photos count];
    CGFloat currentX = 0.0f;
    
    for (int i=0; i <= numberOfImages - 1; i++)
    {
        if (![[photos objectAtIndex:i] isKindOfClass:[NSNull class]])
        {
            // create image
            UIImage *image = [photos objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            // put image on correct position
            CGRect rect =photoScrollView.frame;
            rect.origin.x = currentX;
            imageView.frame = rect;
        
        // update currentX
            currentX += imageView.frame.size.width;

            [photoScrollView addSubview:imageView];
            photoScrollView.contentSize = CGSizeMake(currentX, photoScrollView.frame.size.height);
            
            if ([[selectedItems objectAtIndex:i] isKindOfClass:[[photos objectAtIndex:i] class]])
                
            {
                 [photoScrollView scrollRectToVisible:CGRectMake(currentX - 768.f, 0.f, photoScrollView.frame.size.width, photoScrollView.frame.size.height) animated:NO];
            }
         }
    }
    scrollForwardBtn.hidden = NO;
    scrollBackBtn.hidden = NO;
    
    photoScrollView.hidden = NO;
}


@end
