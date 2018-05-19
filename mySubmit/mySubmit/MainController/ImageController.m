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
    
    UILongPressGestureRecognizer * recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onImageLongPress)];
    [imageView addGestureRecognizer:recognizer];
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
}

- (void)onImageLongPress {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"保存" message:@"是否保存到相册？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    if(!error){
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片保存成功！" preferredStyle:1];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:1 handler:nil];
        
        [alert1 addAction:action];
        
        [self presentViewController:alert1 animated:YES completion:nil];
        
        
        
        
        
        
        
    }else{
        
        NSLog(@"savefailed");
        
    }
    
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
