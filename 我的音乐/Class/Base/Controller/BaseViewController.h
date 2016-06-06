//
//  BaseViewController.h
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
@private
    NSTimer *_hideProgressTimer;
}

/*
 方法说明:
 添加并显示等待条
 
 参数说明:
 UIView* view        添加等待条的View对象
 BOOL    isAnimated  是否出现动画
 
 返回结果:
 void
 */
- (void)showProgressWithView:(UIView*)view animated:(BOOL)isAnimated;

/*
 方法说明:
 隐藏并释放等待条
 
 参数说明:
 UIView* view        隐藏并释放等待条的View对象
 BOOL    isAnimated  是否出现动画
 
 返回结果:
 void
 */
- (void)hideProgress:(UIView*)view animated:(BOOL)isAnimated;


@end
