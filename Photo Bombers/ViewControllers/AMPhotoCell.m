//
//  AMPhotoCell.m
//  Photo Bombers
//
//  Created by ag07 on 25/05/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMPhotoCell.h"

NSString *kImageNamed = @"Treehouse";
@implementation AMPhotoCell

#pragma mark - init 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:kImageNamed];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

#pragma mark - layout 

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView setFrame:[self.contentView bounds]];
}

@end
