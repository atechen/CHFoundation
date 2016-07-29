//
//  URLSessionController.m
//  CHFoundation
//
//  Created by 陈 斐 on 16/7/8.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "URLSessionController.h"
#import "AppDelegate.h"

@interface URLSessionController ()<NSURLSessionDownloadDelegate>
{
    NSURLSession *_session;
}
@end

@implementation URLSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self downloadTaskWithDelegate];
}

#pragma mark - Task
- (void) dataTaskWithBlock
{
    // Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    // Task
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://mapp.my0538.com/api/posts.ashx?page=1&category=2113&action=list"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError *jsonSerError = nil;
            NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonSerError]);
        }
    }];
    [task resume];
}

- (void) dataTaskWithDelegate
{
    // Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://mapp.my0538.com/api/posts.ashx?page=1&category=2113&action=list"]];
    [dataTask resume];
}

- (void) downloadTaskWithDelegate
{
    // Session
    NSURLSessionConfiguration *backgroundConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.atechen.CHFoundation23"];
    NSURLSession *backgroundSession = [NSURLSession sessionWithConfiguration:backgroundConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // Task
//    NSURLSessionDownloadTask *downloadTask = [backgroundSession downloadTaskWithURL:[NSURL URLWithString:@"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg"]];
//    [downloadTask resume];
    NSURLSessionDownloadTask *downloadTask1 = [backgroundSession downloadTaskWithURL:[NSURL URLWithString:@"http://10.1.5.163/demosite/46o4.mp4"]];
    [downloadTask1 resume];
    NSURLSessionDownloadTask *downloadTask2 = [backgroundSession downloadTaskWithURL:[NSURL URLWithString:@"http://10.1.5.163/demosite/66o7.mp4"]];
    [downloadTask2 resume];
    NSURLSessionDownloadTask *downloadTask3 = [backgroundSession downloadTaskWithURL:[NSURL URLWithString:@"http://10.1.5.163/demosite/21o6.mp4"]];
    [downloadTask3 resume];
}

#pragma mark - NSURLSessionDelegate
// 从后台恢复到前台
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.backgroundURLSessionCompletionHandler();
    NSLog(@"******** Session ** EventsForBackground ******");
}

#pragma mark - NSURLSessionTaskDelegate
// 更新上传进度
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"\n\
          ******** Task ** 上传进度 ****** \n\
          本次上传：%lld \n\
          已经上传：%lld \n\
          总体大小：%lld \n\
          ********************************", bytesSent, totalBytesSent, totalBytesExpectedToSend);
}
// 最后一次回调，无论成功失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"******** Task ** didCompleteWithError ******");
}

#pragma mark - NSURLSessionDataDelegate
// 接受数据，多次调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"\n\
          ******** DataTask ** 接受数据 ******：\n\
          data%@ \n\
          ***********************************", data);
    [[NSData data] enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
        
    }];
}

#pragma mark - NSURLSessionDownloadDelegate
// 接受数据，多次调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"\n\
          ******** DownloadTask ** 下载进度 ****** \n\
          本次下载：%lld \n\
          已经上下载：%lld \n\
          总体大小：%lld \n\
          ***************************************", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}
// 恢复下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"\n\
          ******** DownloadTask ** 恢复下载 ****** \n\
          ResumeAtOffset：%lld \n\
          expectedTotalBytes：%lld \n\
          ***************************************", fileOffset, expectedTotalBytes);
}
// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"\n\
          ******** DownloadTask ** 下载完成 ****** \n\
          locationURL：%@ \n\
          ***************************************", location.absoluteString);
}


- (void)dealloc
{
    NSLog(@"URLSessionController - dealloc");
}
@end
