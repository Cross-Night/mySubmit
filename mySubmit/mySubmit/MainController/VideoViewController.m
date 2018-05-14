//
//  VideoViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/15.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "VideoViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoViewController ()<AVPlayerViewControllerDelegate>
//{
//    AVPlayer *_player; /**< 媒体播放器 */
//    AVPlayerViewController * _avPlayerVC; /**< 媒体播放控制器 */
//
//}
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) AVPlayerViewController * avPlayerVC;
@property (nonatomic, strong) UIButton * playBtn;
@property (nonatomic, strong) UIButton * fullPlayBtn;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    self.title = @"视频播放器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.playBtn];
    [self.view addSubview:self.fullPlayBtn];
    
    
    [self.playBtn addTarget:self action:@selector(onPlayVideoClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.fullPlayBtn addTarget:self action:@selector(onFullPlayVideoClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onPlayVideoClicked {
    
//    if (_player) {
//        [_player pause];
//        _player = nil;
//    }
//
//    if (_avPlayerVC) {
//        [_avPlayerVC removeFromParentViewController];
//        [_avPlayerVC.view removeFromSuperview];
//        _avPlayerVC = nil;
//    }
    
    if (self.videoInfo) {
        
        NSURL * movieUrl = [NSURL fileURLWithPath:self.videoInfo.path];
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:movieUrl];
        // 3、根据AVPlayerItem创建媒体播放器
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        // 4、创建AVPlayerLayer，用于呈现视频
         AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        // 5、设置显示大小和位置
        playerLayer.bounds = CGRectMake(0, 0, 350, 300);
        playerLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(playerLayer.bounds) + 30);
        //playerLayer.position = CGPointMake(0,0);
        // 6、设置拉伸模式
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        // 7、获取播放持续时间
        [_player play];
        [self.view.layer insertSublayer:playerLayer atIndex:0];
    }
}

- (void)onFullPlayVideoClicked {
//    if (_player) {
//        [_player pause];
//        _player = nil;
//    }
    
    NSURL * movieUrl = [NSURL fileURLWithPath:self.videoInfo.path];
    if (self.avPlayerVC) {
        self.avPlayerVC = nil;
    }
    
    // 3、配置媒体播放控制器
    self.avPlayerVC = [[AVPlayerViewController alloc]  init];
    // 设置媒体源数据
    self.avPlayerVC.player = [AVPlayer playerWithURL:movieUrl];
    // 设置拉伸模式
    self.avPlayerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    // 设置是否显示媒体播放组件
    self.avPlayerVC.showsPlaybackControls = YES;
    // 设置大力
    self.avPlayerVC.delegate = self;
    
    // 是否显示播放控制条
    self.avPlayerVC.showsPlaybackControls = YES;
    // 设置显示的Frame
    self.avPlayerVC.view.frame = self.view.bounds;
    
    // 设置媒体播放器视图大小
//    self.avPlayerVC.view.bounds = CGRectMake(0, 0, 350, 300);
//    self.avPlayerVC.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(self.avPlayerVC.view.bounds) + 30);
    // 4、推送播放
    // 推送至媒体播放器进行播放
    // [self presentViewController:_playerViewController animated:YES completion:nil];
    // 直接在本视图控制器播放
    [self addChildViewController:self.avPlayerVC];
    [self.view addSubview:self.avPlayerVC.view];
    
    // 播放视频
    [self.avPlayerVC.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//getter
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _playBtn.bounds = CGRectMake(0, 0, 100, 40);
        _playBtn.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 50, CGRectGetMidY(self.view.bounds) + 100);
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
    return _playBtn;
}

- (UIButton *)fullPlayBtn {
    if (!_fullPlayBtn) {
        _fullPlayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _fullPlayBtn.bounds = CGRectMake(0, 0, 100, 40);
        _fullPlayBtn.center = CGPointMake(CGRectGetMidX(self.view.bounds) + 50, CGRectGetMidY(self.view.bounds) + 100);
        [_fullPlayBtn setTitle:@"全屏播放" forState:UIControlStateNormal];
    }
    return _fullPlayBtn;
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
