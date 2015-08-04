//
//  AMDismissDetailTransition.m
//  Photo Bombers
//
//  Created by Amir Ghoreshi on 04/08/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMDismissDetailTransition.h"

@implementation AMDismissDetailTransition

#pragma mark - transition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    //get the viewController from!
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];


    [UIView animateWithDuration:0.3f animations:^{
        destinationViewController.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [destinationViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - duration

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}


@end
