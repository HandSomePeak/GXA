//
//  CZMessage.h
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CZMessageTypeSelf = 0,
    CZMessageTypeOther = 1
} CZMessageType;

@interface CZMessage : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) CZMessageType type;
@property (nonatomic, assign, getter=isHiddenTime) BOOL hiddenTime;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)messageWithDic:(NSDictionary *)dic;

+ (NSArray *)messagesList;
@end
