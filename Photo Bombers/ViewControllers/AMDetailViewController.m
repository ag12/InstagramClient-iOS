//
//  AMDetailViewController.m
//  Photo Bombers
//
//  Created by Amir Ghoreshi on 04/08/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

#import "AMDetailViewController.h"
#import "AMPhotoService.h"

@interface AMDetailViewController ()
@property (nonatomic) UIImageView *imageView;
@end

@implementation AMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.90]];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:self.imageView];

    [AMPhotoService imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGSize size = self.view.bounds.size;
    CGSize imageSize = CGSizeMake(size.width, size.width);

    self.imageView.frame = CGRectMake(0.0, ((size.height - imageSize.height) / 2.0), imageSize.width, imageSize.height);



}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
