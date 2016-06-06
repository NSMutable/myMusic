//
//  LrcTool.m
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "LrcTool.h"
#import "LrcView.h"
#import "LrcModel.h"
#import "NetWorkTool.h"
@class NetWorkTool;
@implementation LrcTool
+ (void)lrcToolDownloadWithUrl:(NSString *)url setUpLrcView:(LrcView *)lrcView
{
    [NetWorkTool netWorkToolDownloadWithUrl:url targetPath:NSDocumentDirectory DomainMask:NSUserDomainMask endPath:^(NSURL *endPath) {
        NSMutableArray *lrcArrayM = [NSMutableArray array];
        NSString *path = (NSString *)endPath;
        NSString *lrc = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *Array = [lrc componentsSeparatedByString:@"\n"];
        for (NSString *lrc in Array) {
            if ([lrc hasPrefix:@"[ti:"] || [lrc hasPrefix:@"[ar:"] || [lrc hasPrefix:@"[al:"] || ![lrc hasPrefix:@"["]) {
                continue;
            }
            LrcModel *lrcModel = [LrcModel lrcModelWithLrcString:lrc];
            [lrcArrayM addObject:lrcModel];
        }
        lrcView.lrcArray = lrcArrayM;
    }];
}
@end
