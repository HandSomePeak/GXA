//
//  Music.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/25.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "Music.h"

@implementation Music

-(id)initWithSongId:(NSString *)songId songName:(NSString *)songType singer:(NSString *)singer region:(NSString *)region link:(NSString *)link{
    if (self = [super init]) {
        _songId = songId;
        _songType = songType;
        _singer = singer;
        _region = region;
        _link = link;
    }
    return  self;
}

@end
