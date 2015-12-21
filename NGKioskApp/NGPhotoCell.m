//
//  PSPhotoCell.m
//  PSPhotoService
//
//  Created by Andrey Karaban on 28/05/15.
//  Copyright (c) 2015 Andrey Karaban. All rights reserved.
//

#import "NGPhotoCell.h"

@interface NGPhotoCell ()
{
    
}

@end

@implementation NGPhotoCell

@synthesize ibThumbNailImage;

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    ibThumbNailImage.alpha = 0.5f;
    
    if (!selected)
    {
        ibThumbNailImage.alpha = 1.0;
    }
}


@end
