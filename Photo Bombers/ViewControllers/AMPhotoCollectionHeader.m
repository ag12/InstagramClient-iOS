//
//  AMPhotoCollectionHeader.m
//  Photo Bombers
//
//  Created by ag07 on 25/05/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMPhotoCollectionHeader.h"

@implementation AMPhotoCollectionHeader

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _title = [UILabel new];
        _title.text = @"#photobomers";
        [self addSubview:_title];
    }
    return self;
}
#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.title setFrame:[self bounds]];
}

@end
