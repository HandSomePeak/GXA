//
//  DownLoading.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "DownLoading.h"
#import "Music.h"
#import "MusicCollection.h"

@implementation DownLoading

-(id)initWithSongName:(NSString *)songName singer:(NSString *)singer alreadyLoad:(long long)alradyLoad length:(long long)length{
    if (self = [super init]) {
        _songName = songName;
        _singer = singer;
        _alreadyLoad = alradyLoad;
        _length = length;
    }
    return self;
}

//下载音乐方法
-(void)DownLoadMusicAddress:(Music *)download{
    NSString *urlString = [self encodeURLString:download.link];
    //创建URL对象
    NSURL *url = [NSURL URLWithString:urlString];
    //需要前台显示下载进程
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    
    _songName = download.songName;
    _singer = download.singer;
    
    //开始下载歌曲
    [downloadTask resume];
}

//中文名称可用化
- (NSString *)encodeURLString:(NSString *)urlString{
    NSMutableCharacterSet *characterSet = (NSMutableCharacterSet *)[NSMutableCharacterSet URLFragmentAllowedCharacterSet];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLHostAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLPasswordAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLPathAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLUserAllowedCharacterSet]];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    return urlString;
}

#pragma mark - NSURLSessionDownloadDelegate 协议方法
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //获取文档路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:downloadTask.currentRequest.URL.lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把下载的临时文件移到到文档目录下
    [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    
}
//下载进程
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //URLSession的下载任务处于异步队列中，更新界面必须放在主线程中
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    _alreadyLoad = totalBytesWritten;
    _length = totalBytesExpectedToWrite;
    
    //创建对象
//    DownLoading *newDL = [[DownLoading alloc]initWithSongName:_songName singer:_singer alreadyLoad:_alreadyLoad length:_length];
    
    
    //    });
    
}


@end
