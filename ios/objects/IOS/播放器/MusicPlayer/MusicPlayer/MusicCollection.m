//
//  MusicCollection.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/25.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "MusicCollection.h"
#import "AVFoundation/AVFoundation.h"
#import "Music.h"

@implementation MusicCollection

static MusicCollection *instance;

+(MusicCollection *)shartedInstance{
    static dispatch_once_t deatice = 0;
    dispatch_once(&deatice, ^{
        if (!instance) {
            instance = [[self alloc]init];
        }
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}

-(id)init{
    if (self = [super init]) {
        _likeArray = [NSMutableArray array];
        _localArray = [NSMutableArray array];
        _recentArray = [NSMutableArray array];
        _startDownLoadArray = [NSMutableArray array];
        _alreadyDown = 0;
        _length = 0;
        _currentSong = [[Music alloc]init];
        _myTimer = [[NSTimer alloc]init];
        _row = 0;
    }
    return self;
}

@end
