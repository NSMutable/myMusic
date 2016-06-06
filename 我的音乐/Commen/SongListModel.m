//
//  SongListModel.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "SongListModel.h"

@implementation SongListModel

+ (NSArray *)mj_allowedPropertyNames
{
    return @[@"pic_500",@"listenum",@"collectnum",@"desc",@"title",@"tag",@"content",@"pic_radio",@"publishtime",@"info",@"author"];
}

@end
