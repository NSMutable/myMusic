//
//  MusicModel.m
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
+ (NSArray *)mj_allowedPropertyNames
{
    return @[@"songName",@"artistName",@"albumName",@"songPicSmall",@"songPicBig",@"songPicRadio",@"songLink",@"lrcLink",@"showLink",@"songId"];
}

@end
