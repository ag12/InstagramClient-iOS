//
//  AMPhotoCell.m
//  Photo Bombers
//
//  Created by ag07 on 25/05/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMPhotoCell.h"
#import "AMPhotoService.h"


NSString *kImageNamed = @"Treehouse";
@implementation AMPhotoCell

#pragma mark - init 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:kImageNamed];


        //UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        //tapGestureRecognizer.numberOfTapsRequired = 2;
        //[self addGestureRecognizer:tapGestureRecognizer];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

#pragma mark - layout 

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView setFrame:[self.contentView bounds]];
}

#pragma mark - photo

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    [AMPhotoService imageForPhoto:_photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

/*- (void)like {
    NSLog(@"TAPP TAPP");

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], token];
    NSLog(@"URL STRING %@", urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"RESPONSE: %@", response);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"RESPONSE: %@", string);


    }];

    [task resume];
}*/
@end
