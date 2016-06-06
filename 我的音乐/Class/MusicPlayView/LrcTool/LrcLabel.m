//
//  LrcLabel.m
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "LrcLabel.h"

@implementation LrcLabel

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGRect drawRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    [UIColorFromRGB(0xfa7e33) set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceIn);
}

@end
