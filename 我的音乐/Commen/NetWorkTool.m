//
//  NetWorkTool.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "ProgressTool.h"
@class ProgressTool;

@implementation NetWorkTool
+ (void)netWorkToolGetWithUrl:(NSString *)url parameters:(NSDictionary *)parameters response:(void (^)(id))success
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            [ProgressTool promptModeText:@"没有网络了" afterDelay:2];
        }else{
            MBProgressHUD *netPrompt = [ProgressTool promptModeIndeterminatetext:@"正在加载中"];
            //加载数据
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript",nil];
            [manger GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    [netPrompt removeFromSuperview];
                    if (success) {
                        success(responseObject);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [netPrompt removeFromSuperview];
            }];
        }
    }];
}

+ (void)netWorkToolDownloadWithUrl:(NSString *)string targetPath:(NSSearchPathDirectory)path DomainMask:(NSSearchPathDomainMask)mask endPath:(void(^)(NSURL *endPath))endPath
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory:path inDomain:mask appropriateForURL:nil create:NO error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error && endPath) {
            endPath(filePath);
        }
    }];
    [downloadTask resume];
}
@end

