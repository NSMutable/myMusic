//
//  MusicModel.h
//  随行之声
//
//  Created by 陈淼 on 16/6/1.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicModel : NSObject
@property (nonatomic ,copy) NSString *songName;
@property (nonatomic ,copy) NSString *artistName;
@property (nonatomic ,copy) NSString *albumName;
@property (nonatomic ,copy) NSString *songPicSmall;
@property (nonatomic ,copy) NSString *songPicBig;
@property (nonatomic ,copy) NSString *songPicRadio;
@property (nonatomic ,copy) NSString *songLink;
@property (nonatomic ,copy) NSString *lrcLink;
//更高品质
@property (nonatomic ,copy) NSString *showLink;
@property (nonatomic ,copy) NSString *songId;
@end
