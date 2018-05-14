//
//  MusicPlayerView.h
//  mySubmit
//
//  Created by demo on 2018/5/13.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol musicPlayerViewDelegate
- (void)onPlayMusic;
- (void)onAdjustVol:(float)value;
@end

@interface MusicPlayerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *volSlider;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) id<musicPlayerViewDelegate> delegate;

+ (instancetype)loadFromNib;

@end
