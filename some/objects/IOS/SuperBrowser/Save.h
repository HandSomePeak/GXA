//
//  Save.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Save : NSObject

//保存热门网站
@property (nonatomic) NSMutableArray *Array;
//存储新闻频道
@property (nonatomic) NSMutableArray *cellArray;
//存储主页网址
@property (nonatomic) NSString *string;
//收藏夹
@property (nonatomic) NSMutableArray *collectionArray;
//城市名称
@property (nonatomic) NSString *cityname;

+(Save *)sharedInstance;

@end
