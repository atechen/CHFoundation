//
//  URLSessionController.m
//  CHFoundation
//
//  Created by 陈 斐 on 16/7/8.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "URLSessionController.h"

@interface URLSessionController ()<NSURLSessionDataDelegate>
{
    NSURLSession *_session;
}
@end

@implementation URLSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURLSessionConfiguration *backgroundConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.atechen.CHFoundation"];
    NSURLSession *backgroundSession = [NSURLSession sessionWithConfiguration:backgroundConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // http://mapp.my0538.com/api/posts.ashx?page=1&db=%E6%B3%B0%E5%AE%89&category=2113&action=list
    NSURLSessionDataTask *dataTask = [backgroundSession dataTaskWithURL:[NSURL URLWithString:@"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg"]];
    [dataTask resume];
    
//    NSURLSessionDownloadTask *downloadTask = [backgroundSession downloadTaskWithURL:[NSURL URLWithString:@"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg"]];
//    [downloadTask resume];
    
}

- (void) blockSession
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://mapp.my0538.com/api/posts.ashx?page=1&db=%E6%B3%B0%E5%AE%89&category=2113&action=list"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError *jsonSerError = nil;
            NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonSerError]);
        }
    }];
    
    [task resume];
}

#pragma mark - NSURLSessionDataTaskDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"------NSURLSessionDataTask-----%@", data);
}

#pragma mark - NSURLSessionDownloadTaskDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"NSURLSessionDownloadTask-----didWriteData：%lld---totalBytesWritten：%lld---totalBytesExpectedToWrite：%lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}


- (void)dealloc
{
    NSLog(@"URLSessionController - dealloc");
}
@end
