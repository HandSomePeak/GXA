//
//  Save.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "Save.h"
#import "HotNet.h"

@implementation Save
static Save *instance;

+(Save *)sharedInstance{
    if (!instance) {
        instance = [[Save alloc]init];
    }
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        static dispatch_once_t predicte;
        dispatch_once(&predicte, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

-(id)init{
    if (self == [super init]) {
        _Array = [NSMutableArray array];
        _cellArray = [NSMutableArray arrayWithArray:@[
                       [[HotNet alloc]initWithName:@"国内新闻" address:@"http://news.qq.com/newsgn/rss_newsgn.xml" image:nil],
                       [[HotNet alloc]initWithName:@"国际新闻" address:@"http://news.qq.com/newsgj/rss_newswj.xml" image:nil],
                       [[HotNet alloc]initWithName:@"社会新闻" address:@"http://news.qq.com/newssh/rss_newssh.xml" image:nil],
                       [[HotNet alloc]initWithName:@"图片站" address:@"http://news.qq.com/photon/rss_photo.xml" image:nil],
                       [[HotNet alloc]initWithName:@"评论站" address:@"http://news.qq.com/newscomments/rss_comment.xml" image:nil],
                       [[HotNet alloc]initWithName:@"军事站" address:@"http://news.qq.com/milite/rss_milit.xml" image:nil],
                       [[HotNet alloc]initWithName:@"史海钩沉" address:@"http://news.qq.com/histor/rss_history.xml" image:nil],
                       [[HotNet alloc]initWithName:@"新闻语录" address:@"http://news.qq.com/xwyl/rss_xwyl.xml" image:nil],
                       [[HotNet alloc]initWithName:@"数字说话" address:@"http://news.qq.com/szsh/rss_szsh.xml" image:nil],
                       [[HotNet alloc]initWithName:@"内幕黑幕" address:@"http://news.qq.com/nehemu/rss_nmhm.xml" image:nil],
                       [[HotNet alloc]initWithName:@"人物站" address:@"http://news.qq.com/person/rss_person.xml" image:nil],
                       [[HotNet alloc]initWithName:@"即时消息" address:@"http://news.qq.com/zmdnew/rss_now.xml" image:nil],
                       [[HotNet alloc]initWithName:@"地方站-北京" address:@"http://news.qq.com/bj/rss_bj.xml" image:nil],
                       [[HotNet alloc]initWithName:@"地方站-上海" address:@"http://news.qq.com/sh/rss_sh.xml" image:nil],
                       [[HotNet alloc]initWithName:@"地方站-广东" address:@"http://news.qq.com/gd/rss_gd.xml" image:nil],
                       [[HotNet alloc]initWithName:@"地方站-浙江" address:@"http://news.qq.com/js/rss_js.xml" image:nil]
                       ]];
        _collectionArray = [NSMutableArray array];
        _string = [[NSString alloc]init];
//        _cityname = @"北京";
        _cityname = [[NSString alloc]init];
    }
    return self;
}

@end
