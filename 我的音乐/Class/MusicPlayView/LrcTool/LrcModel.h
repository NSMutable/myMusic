//
//  LrcModel.h
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSString *text;
- (instancetype)initWithLrcString:(NSString *)lrcString;
+ (instancetype)lrcModelWithLrcString:(NSString *)lrcString;
@end
