//
//  RegisterViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserCache.h"
//#import "UserInfo.h"
#import "UserDBManager.h"
#import "LoginViewController.h"


@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userIDTf;
@property (weak, nonatomic) IBOutlet UITextField *passWordTf;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)onRegister:(UIButton *)sender {
    UserInfo * info = [[UserInfo alloc] init];
    if ((![self.userIDTf.text isEqualToString:@""])&&(![self.passWordTf.text isEqualToString:@""])) {
        info.userID = self.userIDTf.text;
        info.passWord = self.passWordTf.text;
        //[[UserCache shareCache] saveUserInfo:info];
        if ([[UserDBManager defaultManager] getUserWithUserID:info.userID] != nil) {
            UIAlertController * existAlertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户已存在" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAct = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
            [existAlertVC addAction:cancelAct];
            [self presentViewController:existAlertVC animated:YES completion:nil];
        }else{
            BOOL success =[[UserDBManager defaultManager] insertUser:info];
            if (success) {
                UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alertAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    //                LoginViewController * loginVC = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    //                [self.navigationController pushViewController:loginVC animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertVC addAction:alertAct];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.userIDTf resignFirstResponder];
    [self.passWordTf resignFirstResponder];
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
