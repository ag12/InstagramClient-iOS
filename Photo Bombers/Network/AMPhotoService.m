//
//  AMPhotoController.m
//  Photo Bombers
//
//  Created by Amir Ghoreshi on 04/08/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMPhotoService.h"
#import <SAMCache/SAMCache.h>


@implementation AMPhotoService

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(Completion)completion {

    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
    NSString *key = [[NSString alloc] initWithFormat:@"%@-thumbnail", photo[@"id"]];
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];
    if (image) {
        completion(image);
        return;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {

        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        [[SAMCache sharedCache] setImage:image forKey:key];

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    }];
    [task resume];
}

@end
