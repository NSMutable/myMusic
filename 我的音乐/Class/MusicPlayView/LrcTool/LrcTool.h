//
//  LrcTool.h
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LrcView;
@interface LrcTool : NSObject
+ (void)lrcToolDownloadWithUrl:(NSString *)url setUpLrcView:(LrcView *)lrcView;

@end
