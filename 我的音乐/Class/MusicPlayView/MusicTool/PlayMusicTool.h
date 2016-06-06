//
//  PlayMusicTool.h
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface PlayMusicTool : NSObject

+ (AVPlayerItem *)playMusicWithLink:(NSString *)link;

+ (void)pauseMusicWithLink:(NSString *)link;

+ (void)stopMusicWithLink:(NSString *)link;

+ (void)setUpCurrentPlayingTime:(CMTime)time link:(NSString *)link;
@end
