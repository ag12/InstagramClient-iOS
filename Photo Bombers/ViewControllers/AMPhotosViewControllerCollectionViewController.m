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

@interface AMPhotosViewControllerCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
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
    [self download];
}

- (void)download {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"response %@", response);
        NSLog(@"location %@", location);
        if (!error) {
            NSString *downloadString = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"RESPONSE: %@", downloadString);
        }
    }];
    [task resume];
    
}

#pragma mark - datasource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

#pragma mark - delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AMPhotoCell *cell = (AMPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
