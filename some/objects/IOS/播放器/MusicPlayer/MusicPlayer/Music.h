//
//  Music.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/25.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic) NSString *songId;
@property (nonatomic) NSString *songName;
@property (nonatomic) NSString *songType;
@property (nonatomic) NSString *singer;
@property (nonatomic) NSString *region;
@property (nonatomic) NSString *link;

-(id)initWithSongId:(NSString *)songId songName:(NSString *)songType singer:(NSString *)singer region:(NSString *)region link:(NSString *)link;

@end
