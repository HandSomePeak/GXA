//
//  CZMessage.m
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *messages = [NSMutableArray array];
     CZMessage *lastMessage;
    for (NSDictionary *dic in dicArray) {
        CZMessage *message = [[CZMessage alloc] initWithDic:dic];
        
        if ([message.time isEqualToString:lastMessage.time]) {
            message.hiddenTime = YES;
        }
       
        
        [messages addObject:message];
        
        lastMessage = message;
    }
    return messages;
}

@end
