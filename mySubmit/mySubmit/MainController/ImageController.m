//
//  ImageController.m
//  mySubmit
//
//  Created by demo on 2018/5/13.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "ImageController.h"

@interface ImageController ()

@end

@implementation ImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片";
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
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

@end
