//
//  MusicController.m
//  mySubmit
//
//  Created by demo on 2018/5/14.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "MusicController.h"
#import "MusicPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import <ReactiveCocoa.h>

@interface MusicController ()<musicPlayerViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong) AVAudioPlayer * audioPlayer;
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,strong) MusicPlayerView * musicPlayerView;
@property (nonatomic,strong) UIImageView * bgImageView;
@end

@implementation MusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.musicPlayerView.delegate = self;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.bgImageView];
    self.bgImageView.image = [UIImage imageNamed:@"submit_center"];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.musicPlayerView];
    [self.musicPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    if (self.musicInfo) {
        AVURLAsset * musicAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:self.musicInfo.path] options:nil];
        for (NSString * format in [musicAsset availableMetadataFormats]) {
            for (AVMetadataItem * item in [musicAsset metadataForFormat:format]) {
                if ([item.commonKey isEqualToString:@"artwork"]) {
//                    NSDictionary * dict = (NSDictionary *)item.value;
//                    NSData * data = [dict objectForKey:@"data"];
                    NSData * data = (NSData *)item.value;
                    self.bgImageView.image = [UIImage imageWithData:data];
                   
                }else{
                }
            }
        }
        self.musicPlayerView.musicNameLabel.text = self.musicInfo.name;
        NSURL * url = [NSURL fileURLWithPath:self.musicInfo.path];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.musicInfo.path] error:nil];
        self.audioPlayer.numberOfLoops = 1;
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPlayMusic {
    if (self.audioPlayer.isPlaying == YES) {
        [self.audioPlayer pause];
        [self.musicPlayerView.playBtn setBackgroundImage:[UIImage imageNamed:@"pausing"] forState:UIControlStateNormal];
        self.timer.fireDate=[NSDate distantFuture];//暂停定时器
    }else{
        [self.audioPlayer play];
        [self.musicPlayerView.playBtn setBackgroundImage:[UIImage imageNamed:@"playing"] forState:UIControlStateNormal];
        self.timer.fireDate=[NSDate distantPast];//恢复定时器
    }
}

- (void)onAdjustVol:(float)value {
    [self.audioPlayer setVolume:value];
}

//getter方法

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

- (MusicPlayerView *)musicPlayerView{
    if (!_musicPlayerView) {
        _musicPlayerView = [MusicPlayerView loadFromNib];
    }
    return _musicPlayerView;
}


/*
//获取歌曲信息列表
- (NSString *)getMusicArtistsWithFilesURL:(NSURL *)fileURL {
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    NSMutableArray *artists = [[AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon] mutableCopy];
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    
    NSString * artistStr = [NSString string];
    
    if (artists.count > 0) {
        AVMetadataItem *artist = [artists objectAtIndex:0];
        artistStr = [artist.value copyWithZone:nil];
    }else{
        artistStr = @"未知歌手";
    }
    
    
    //AVMetadataItem *title = [titles objectAtIndex:0];
    //AVMetadataItem *albumName = [albumNames objectAtIndex:0];
    
    
        NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
        [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
            NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                               withKey:AVMetadataCommonKeyArtwork
                                                              keySpace:AVMetadataKeySpaceCommon];
    
            for (AVMetadataItem *item in artworks) {
                if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                    NSDictionary *d = [item.value copyWithZone:nil];
                    self.bgImageView.image = [UIImage imageWithData:[d objectForKey:@"data"]];
                } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                    self.bgImageView.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
                }
            }
        }];
    //self.mSongName.text = [title.value copyWithZone:nil];
    //NSString *albumNamtStr = [albumName.value copyWithZone:nil];
    //NSTimeInterval duration = self.mAudioPlayer.duration;
    //NSInteger minute = duration/60;
    //NSInteger seconde = duration - (minute * 60);
    
    //self.mCurrentTimeLabel.text = [NSString stringWithFormat:@"%d:%d",minute,seconde];
    
    //NSLog(@"artist:%@  albumName:%@",artistStr, albumNamtStr);
    return artistStr;
}
*/

@end
