//
//  AMPhotoController.h
//  Photo Bombers
//
//  Created by Amir Ghoreshi on 04/08/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Completion)(UIImage *image);



@interface AMPhotoService : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(Completion)completion;

@end
