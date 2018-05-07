//
//  SubmitViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/3.
//  Copyright © 2018年 demo. All rights reserved.
//

#define R_VALUE(argb) ((argb >> 16) & 0x000000FF)
#define G_VALUE(argb) ((argb >> 8) & 0x000000FF)
#define B_VALUE(argb) (argb & 0x000000FF)

#import "SubmitViewController.h"
#import "fileListTableViewController.h"
#import <ReactiveCocoa.h>


@interface SubmitViewController (){
    HTTPServer * httpServer;
}

//fileArray
@property (nonatomic, strong) NSMutableArray *fileArray;
@property (nonatomic, strong) NSString * ipString;
@property (nonatomic, assign) NSInteger fileCount;

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fileCount = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFile) name:@"processEpilogueData" object:nil];
    
    // 获取文件存储位置
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"filePath : %@", filePath);
    
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    NSString *webPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"webPath : %@", webPath);
    [httpServer setDocumentRoot:webPath];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    NSError *err;
    
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    if ([httpServer start:&err]) {
        
        self.ipString = [NSString string];
        
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            self.ipString = @"（您正在4G/3G/2G网络下，暂无法使用）";
            self.wifiLabel.text = @"请连接WIFI";
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            self.ipString = @"您当前无网络";
            self.wifiLabel.text = @"请连接WIFI";
        }else{
            self.ipString = [NSString stringWithFormat:@"http://%@:%d/",[SJXCSMIPHelper deviceIPAdress],[httpServer listeningPort]];
            self.wifiLabel.text = @"已连接WIFI";
        }
        self.ipAddressLabel.text = self.ipString;
        NSLog(@"ipString : %@",self.ipString);
        //  self.showIpLabel.hidden = NO;
        //        NSString *ipString = [NSString stringWithFormat:@"请在网页输入这个地址  http://%@:%hu/", [SJXCSMIPHelper deviceIPAdress], [httpServer listeningPort]];
        // self.showIpLabel.text = ipString;
        //        NSLog(@"ipString : %@", ipString);
        
    }else{
        NSLog(@"%@",err);
    }
    
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                self.ipAddressLabel.text = @"您当前无网络";
                self.wifiLabel.text = @"请连接WIFI";
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                self.ipAddressLabel.text = @"您正在4G/3G/2G网络下，暂无法使用";
                self.wifiLabel.text = @"请连接WIFI";
                break;
            default:
                self.ipAddressLabel.text = self.ipString;
                self.wifiLabel.text = @"已连接WIFI";
                break;
        }
    }];
    

    // Do any additional setup after loading the view.
}

- (void)showFile {
    NSLog(@"连通了");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSLog(@"地址：%@", documentsPath);
        
        self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:documentsPath error:nil]];
        //[self.fileTableView reloadData];
        
        self.fileCount ++;
        [self showFileCount:self.fileCount];
    });
    
}


- (void)showFileCount:(NSInteger)count {   //更新界面
    NSString * countStr = [NSString stringWithFormat:@"%ld",count];
    NSString * countLabelStr = [NSString stringWithFormat:@"已导入%ld个文件",count];
    UIColor * blackColor = [self colorWithHexString:@"#666666" alpha:1.0];
    NSMutableAttributedString * AttriStr = [[NSMutableAttributedString alloc] initWithString:countLabelStr];
    NSDictionary * dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:blackColor};
    [AttriStr setAttributes:dic range:NSMakeRange(3, countStr.length)];
    self.fileCountLabel.attributedText = AttriStr;
}

- (UIColor *)colorWithHexString:(NSString *)colorString alpha:(CGFloat)alpha
{
    const char *cStr = [colorString cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr + 1, NULL, 16);
    
    UIColor *color =  [UIColor colorWithRed:(float)R_VALUE(x) / 255.0f green:(float)G_VALUE(x) / 255.0f blue:(float)B_VALUE(x) / 255.0f alpha:alpha];
    
    return color;
}


- (IBAction)onDoneBtnClicked:(UIButton *)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    fileListTableViewController * fileListVC = (fileListTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"fileListTableViewController"];
    fileListVC.fileList = @[@"1",@"2",@"3"];
    NSInteger count = fileListVC.fileList.count;
    [self.navigationController pushViewController:fileListVC animated:YES];
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
