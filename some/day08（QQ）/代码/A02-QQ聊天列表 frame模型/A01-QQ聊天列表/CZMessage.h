//
//  CZMessage.h
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>


//枚举：是一组和数值相关的常量

//enum CZMessageType
//{
//    CZMessageTypeSelf = 0,
//    CZMessageTypeOther = 1
//};
//
//typedef enum CZMessageType CZMessageType;


typedef enum {
    CZMessageTypeSelf,
    CZMessageTypeOther
} CZMessageType;

@interface CZMessage : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;

@property (nonatomic,assign) CZMessageType type;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)messageWithDic:(NSDictionary *)dic;

+ (NSArray *)messagesList;

@end
