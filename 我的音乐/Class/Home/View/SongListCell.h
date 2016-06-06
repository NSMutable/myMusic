//
//  SongListCell.h
//  随行之声
//
//  Created by 陈淼 on 16/5/31.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongListDetailModel.h"

@class SongListDetailModel;

@interface SongListCell : UITableViewCell

@property (nonatomic, strong) SongListDetailModel *detailModel;

@property (nonatomic, assign) BOOL state;

@property (nonatomic, strong) UIButton *addBtn;

@end

