//
//  MusicCollection.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/25.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

@class Music;
@interface MusicCollection : NSObject

//播放器
@property (nonatomic) AVAudioPlayer *audioPlayer;
//保存当前播放的歌曲
@property (nonatomic) Music *currentSong;
//保存当前播放歌曲的位置
@property (nonatomic) NSInteger row;
//定时器
@property (nonatomic) NSTimer *myTimer;
//本地音乐
@property (nonatomic) NSMutableArray *localArray;
//我喜欢
@property (nonatomic) NSMutableArray *likeArray;
//最近播放
@property (nonatomic) NSMutableArray *recentArray;
//正在下载列表
@property (nonatomic) NSMutableArray *startDownLoadArray;
//已下载时间
@property (nonatomic) long long alreadyDown;
//总时间
@property (nonatomic) long long length;

+(MusicCollection *)shartedInstance;

@end
