//
//  PlayMusicTool.m
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "PlayMusicTool.h"
#import "PlayerQueue.h"

@implementation PlayMusicTool
static NSMutableDictionary *_playingMusic;

+ (void)initialize
{
    _playingMusic = [NSMutableDictionary dictionary];
}

+ (AVPlayerItem *)playMusicWithLink:(NSString *)link
{
    PlayerQueue *queue = [PlayerQueue sharePlayerQueue];
    AVPlayerItem *playItem = _playingMusic[link];
    if (!playItem) {
        playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:link]];
        [_playingMusic setObject:playItem forKey:link];
        [queue replaceCurrentItemWithPlayerItem:playItem];
    }
    [queue play];
    return playItem;
}


+ (void)pauseMusicWithLink:(NSString *)link {
    AVPlayerItem *playItem = _playingMusic[link];
    if (playItem) {
        PlayerQueue *queue = [PlayerQueue sharePlayerQueue];
        [queue pause];
    }
}

+ (void)stopMusicWithLink:(NSString *)link
{
    AVPlayerItem *playItem = _playingMusic[link];
    if (playItem) {
        PlayerQueue *queue = [PlayerQueue sharePlayerQueue];
        [_playingMusic removeAllObjects];
        [queue removeItem:playItem];
    }
}

+ (void)setUpCurrentPlayingTime:(CMTime)time link:(NSString *)link
{
    AVPlayerItem *playItem = _playingMusic[link];
    PlayerQueue *queue = [PlayerQueue sharePlayerQueue];
    [playItem seekToTime:time completionHandler:^(BOOL finished) {
        [_playingMusic setObject:playItem forKey:link];
        [queue play];
    }];
}

@end
