//
//  SongListDetailModel.h
//  随行之声
//
//  Created by 陈淼 on 16/5/31.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongListDetailModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *song_id;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic ,copy) NSString *pic_small;
@property (nonatomic, assign) NSInteger num;
@end
