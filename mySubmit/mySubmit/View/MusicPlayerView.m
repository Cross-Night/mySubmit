//
//  MusicPlayerView.m
//  mySubmit
//
//  Created by demo on 2018/5/13.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "MusicPlayerView.h"

@implementation MusicPlayerView

+ (instancetype)loadFromNib{
    return [[NSBundle mainBundle] loadNibNamed:@"MusicPlayerView" owner:self options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}


- (IBAction)onPlayBtnClicked:(UIButton *)sender {
    if (_delegate) {
        [_delegate onPlayMusic];
    }
}

- (IBAction)onVolValueChanged:(UISlider *)sender {
    if (_delegate) {
        [_delegate onAdjustVol:sender.value];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
