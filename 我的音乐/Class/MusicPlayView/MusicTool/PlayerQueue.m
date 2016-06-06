//
//  PlayerQueue.m
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "PlayerQueue.h"

@implementation PlayerQueue
static id _playerQueue;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playerQueue = [super allocWithZone:zone];
    });
    return _playerQueue;
}

+ (instancetype)sharePlayerQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playerQueue = [[self alloc] init];
    });
    return _playerQueue;
}

@end
