//
//  LoginViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "LoginViewController.h"
#import "SubmitViewController.h"
#import "beginSubmitViewController.h"
#import "UserInfo.h"
#import "UserDBManager.h"
#import "AccountManager.h"

@interface LoginViewController ()
@property (nonatomic, strong)UserInfo * info;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userIDLabel.text = nil;
    self.passWordLabel.text = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.userIDLabel resignFirstResponder];
    [self.passWordLabel resignFirstResponder];
}

- (IBAction)onLoginBtnClicked:(UIButton *)sender {
    self.info = [[UserDBManager defaultManager] getUserWithUserID:self.userIDLabel.text];
    if (self.info!=nil && [self.info.userID isEqualToString:self.userIDLabel.text] && [self.info.passWord isEqualToString:self.passWordLabel.text]) {
        [self performSegueWithIdentifier:@"login2Main" sender:nil];
      
    }else{
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"再输一次" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


- (IBAction)onRegisterBtnClicked:(UIButton *)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"login2Main"]) {
        beginSubmitViewController * beginVC = segue.destinationViewController;
        [AccountManager defaultManager].info = self.info;
        //UserInfo * testInfo = [AccountManager defaultManager].info;
        beginVC.info = self.info;
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
