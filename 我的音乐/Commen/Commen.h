
//
//  Commen.h
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#ifndef Commen_h
#define Commen_h

#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "UIView+UIViewController.h"
#import "NetWorkTool.h"

#define CMUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting"

#define CMParams(...) @{@"from":@"ios",@"version":@"5.5.6",@"channel":@"appstore",@"operator":@"1",@"format":@"json",__VA_ARGS__}
#define CMMusic @"http://ting.baidu.com/data/music/links"

#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;

//默认坐标相关宏定义
#define NavigationBar_HEIGHT 44
#define UILABEL_DEFAULT_FONT_SIZE 20.0f


//当前系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define IOS7Later [[[UIDevice currentDevice] systemVersion]floatValue]>=7

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//图片大小是360 ＊ 640
#define kWidth(R) (R)*(kScreenWidth)/360
#define kHeight(R) (iPhone4?((R)*(kScreenHeight)/480):((R)*(kScreenHeight)/640))

//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define kWhiteColor     [UIColor whiteColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kBlackColor     [UIColor blackColor]
#define kClearColor     [UIColor clearColor]
#define kGrayColor      [UIColor grayColor]
#define kRedColor      [UIColor redColor]
#define kYellowColor      [UIColor yellowColor]
#define kGreenColor      [UIColor greenColor]

#define IMAGE(img) [UIImage imageNamed:img]

#define k12Font [UIFont systemFontOfSize:12.0f]
#define k14Font [UIFont systemFontOfSize:14.0f]
#define k15Font [UIFont systemFontOfSize:15.0f]
#define k18Font [UIFont systemFontOfSize:18.0f]

#endif /* Commen_h */
