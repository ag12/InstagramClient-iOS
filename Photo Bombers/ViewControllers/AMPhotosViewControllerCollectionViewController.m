//
//  AMPhotosViewControllerCollectionViewController.m
//  Photo Bombers
//
//  Created by ag07 on 25/05/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMPhotosViewControllerCollectionViewController.h"
#import "AMPhotoCollectionHeader.h"
#import "AMPhotoCollectionFooter.h"
#import "AMPhotoCell.h"
#import <SimpleAuth.h>
#import "AMDetailViewController.h"
#import "AMPresentDetailTransition.h"
#import "AMDismissDetailTransition.h"


@interface AMPhotosViewControllerCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;
@end

@implementation AMPhotosViewControllerCollectionViewController

static NSString * const reuseIdentifier = @"photo";


- (void)viewDidLoad {

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(106.0f, 106.0f);
    layout.minimumInteritemSpacing = 1.0f;
    layout.minimumLineSpacing = 1.0f;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[AMPhotoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.collectionView];
    //FOR Header & footer
    //layout.headerReferenceSize = CGSizeMake(320.f, 30.f);
    //layout.footerReferenceSize = CGSizeMake(320.f, 30.f);
    //[self.collectionView registerClass:[AMPhotoCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    //[self.collectionView registerClass:[AMPhotoCollectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    self.title = @"Photo Bombers";

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];

    if (self.accessToken == nil) {

        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes", @"comments"]} completion:^(NSDictionary *dictionary, NSError *error) {
            LogTrace(dictionary[@"credentials"][@"token"]);
            self.accessToken = dictionary[@"credentials"][@"token"];
            if (self.accessToken != nil) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.accessToken forKey:@"accessToken"];
                [userDefaults synchronize];
                [self downloadFromInstagram];
            }

        }];
    } else {
        [self downloadFromInstagram];
    }

}

- (void)downloadFromInstagram {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/netlight/media/recent?access_token=%@", self.accessToken]]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"RES %@", response);
        if (!error) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //NSString *downloadString = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
            self.photos = [responseDictionary valueForKeyPath:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.collectionView reloadData];
            });
        } else if (error) {
        }
    }];
    [task resume];
    
}

#pragma mark - datasource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.photos count];
}

#pragma mark - delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AMPhotoCell *cell = (AMPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.photo = self.photos[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *photo = self.photos[indexPath.row];
    AMDetailViewController *detailViewController = [AMDetailViewController new];
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    detailViewController.transitioningDelegate = self;
    detailViewController.photo = photo;

    [self presentViewController:detailViewController animated:YES completion:nil]; 
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [AMPresentDetailTransition new];

}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [AMDismissDetailTransition new];
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
}

/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
     
        AMPhotoCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
        headerView.title.text = title;
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        AMPhotoCollectionFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableview = footerView;
    }
    
    return reusableview;
}*/
@end
