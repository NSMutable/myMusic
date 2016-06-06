//
//  LrcCell.h
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcLabel.h"
@class LrcLabel;

@interface LrcCell : UITableViewCell
@property (nonatomic, weak, readonly) LrcLabel *lrcLabel;

@end
