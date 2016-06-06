//
//  PublicMusictablesModel.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "PublicMusictablesModel.h"

@implementation PublicMusictablesModel
+ (NSArray *)mj_allowedPropertyNames
{
    return @[@"listid",@"listenum",@"title",@"pic_300",@"pic_big",@"author",@"album_id"];
}
@end
