//
//  LargeMusicController.h
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "BaseViewController.h"
#import "MusicModel.h"
#import "LrcView.h"
#import "LrcTool.h"
#import "PlayMusicTool.h"
#import "MusicModel.h"

@interface LargeMusicController : BaseViewController

- (void)setplayerItem:(AVPlayerItem *)item musicModel:(MusicModel *)model;

@property (nonatomic ,strong) MusicModel *currentMusic;

@end
