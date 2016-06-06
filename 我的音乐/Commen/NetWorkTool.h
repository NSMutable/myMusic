//
//  NetWorkTool.h
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NetWorkTool : NSObject

+ (void)netWorkToolGetWithUrl:(NSString *)url parameters:(NSDictionary *)parameters response:(void(^)(id response))success;
+ (void)netWorkToolDownloadWithUrl:(NSString *)string targetPath:(NSSearchPathDirectory)path DomainMask:(NSSearchPathDomainMask)mask endPath:(void(^)(NSURL *endPath))endPath;
@end

