//
//  DownLoading.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoading : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic) NSString *songName;
@property (nonatomic) NSString *singer;
@property (nonatomic) long long alreadyLoad;
@property (nonatomic) long long length;

-(id)initWithSongName:(NSString *)songName singer:(NSString *)singer alreadyLoad:(long long)alradyLoad length:(long long)length;

//下载音乐方法
-(void)DownLoadMusicAddress:(NSString *)address;

@end
