//
//  LrcView.h
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LrcView : UIView


@property (nonatomic ,assign) NSTimeInterval currentTime;
@property (nonatomic ,strong) NSArray *lrcArray;

@end
