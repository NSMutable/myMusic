//
//  SongListModel.h
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongListModel : NSObject


@property (nonatomic, copy) NSString *pic_500;
@property (nonatomic, copy) NSString *listenum;
@property (nonatomic, copy) NSString *collectnum;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSArray *content;

@property (nonatomic ,copy) NSString *pic_radio;
@property (nonatomic ,copy) NSString *publishtime;
@property (nonatomic ,copy) NSString *info;
@property (nonatomic ,copy) NSString *author;

@end
