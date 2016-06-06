//
//  SongListDetailModel.m
//  随行之声
//
//  Created by 陈淼 on 16/5/31.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "SongListDetailModel.h"

@implementation SongListDetailModel

+ (NSArray *)mj_allowedPropertyNames
{
    return @[@"title",@"song_id",@"author",@"album_title",@"pic_small"];

}

@end
