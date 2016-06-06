//
//  ProgressTool.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "ProgressTool.h"

@implementation ProgressTool
+ (MBProgressHUD *)promptMode:(MBProgressHUDMode)mode text:(NSString *)text afterDelay:(NSInteger)time
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *prompt = [MBProgressHUD showHUDAddedTo:view animated:YES];
    prompt.userInteractionEnabled = NO;
    prompt.mode = mode;
    prompt.labelFont = [UIFont systemFontOfSize:15];
    prompt.labelText = text;
    prompt.margin = 10.f;
    prompt.removeFromSuperViewOnHide = YES;
    [prompt hide:YES afterDelay:time];
    return prompt;
}
+ (void)promptModeText:(NSString *)text afterDelay:(NSInteger)time
{
    [self promptMode:MBProgressHUDModeText text:text afterDelay:time];
}

+ (MBProgressHUD *)promptModeIndeterminatetext:(NSString *)text
{
    return [self promptMode:MBProgressHUDModeIndeterminate text:text afterDelay:60];
}
@end