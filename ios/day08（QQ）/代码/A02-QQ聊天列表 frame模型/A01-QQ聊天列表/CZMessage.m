//
//  CZMessage.m
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZMessage.h"

@implementation CZMessage
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)messageWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
+ (NSArray *)messagesList
{
    //读取plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    //字典转模型
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in dicArray) {
        CZMessage *message = [CZMessage messageWithDic:dic];
        [tmpArray addObject:message];
    }
    return tmpArray;
}
@end
