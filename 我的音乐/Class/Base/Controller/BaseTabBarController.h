//
//  BaseTabBarController.h
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface BaseTabBarController : UITabBarController

- (void)setSongIdArray:(NSMutableArray *)array currentIndex:(NSInteger)index;

@property (nonatomic ,strong) MusicModel *currentMusic;

@end
