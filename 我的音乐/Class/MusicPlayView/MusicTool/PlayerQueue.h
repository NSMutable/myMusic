//
//  PlayerQueue.h
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface PlayerQueue : AVQueuePlayer
+ (instancetype)sharePlayerQueue;
@end
