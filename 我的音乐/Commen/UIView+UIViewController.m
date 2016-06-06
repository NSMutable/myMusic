//
//  UIView+UIViewController.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/20.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    while (YES) {
        if ([next isKindOfClass:[UIViewController class]]) {
            break;
        }else {
            next = next.nextResponder;
        }
    }
    
    return (UIViewController *)next;
}
@end
