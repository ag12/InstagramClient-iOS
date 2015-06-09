//
//  AppDelegate.m
//  Photo Bombers
//
//  Created by ag07 on 25/05/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AppDelegate.h"
#import "AMPhotosViewControllerCollectionViewController.h"
#import <SimpleAuth.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[AMPhotosViewControllerCollectionViewController new]];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242.0f / 255.0f green:122.0f / 255.0f blue:87.0f / 255.0f alpha:1.0f];
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque; //titles and style to white.
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    SimpleAuth.configuration[@"instagram"] = @{@"client_id" : @"c7f8546eca7e474d99d1be0292acafed", SimpleAuthRedirectURIKey :@"http://vg.no"};
    [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *dictionary, NSError *error) {
        NSString *token = dictionary[@"credentials"][@"token"];
    
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
