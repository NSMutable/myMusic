//
//  BaseViewController.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    // Do any additional setup after loading the view.
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
- (void)showProgressWithView:(UIView*)view animated:(BOOL)isAnimated{
    [self hideProgress:view animated:NO];
    
    MBProgressHUD *loading = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
    loading.mode=MBProgressHUDModeIndeterminate;
    loading.color = [UIColor lightGrayColor];
    
    _hideProgressTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f
                                                          target:self
                                                        selector:@selector(handleTimer:)
                                                        userInfo:view
                                                         repeats:NO];
}
/*
 方法说明:
 隐藏并释放等待条
 
 参数说明:
 UIView* view        隐藏并释放等待条的View对象
 BOOL    isAnimated  是否出现动画
 
 返回结果:
 void
 */
- (void)hideProgress:(UIView*)view animated:(BOOL)isAnimated{
    
    if (nil != _hideProgressTimer && [_hideProgressTimer isValid]) {
        [_hideProgressTimer invalidate];
        //        [_hideProgressTimer release];
        _hideProgressTimer = nil;
    }
    [MBProgressHUD hideHUDForView:view animated:isAnimated];
    
}

/*
 方法说明:
 定时隐藏并释放等待条
 
 参数说明:
 定时器对象
 
 返回结果:
 void
 */
- (void)handleTimer:(NSTimer *)timer {
    
    [self hideProgress:[timer userInfo] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

