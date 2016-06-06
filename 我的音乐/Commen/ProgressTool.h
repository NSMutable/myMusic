//
//  ProgressTool.h
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface ProgressTool : NSObject
+ (void)promptModeText:(NSString *)text afterDelay:(NSInteger)time;
+ (MBProgressHUD *)promptModeIndeterminatetext:(NSString *)text;
@end
