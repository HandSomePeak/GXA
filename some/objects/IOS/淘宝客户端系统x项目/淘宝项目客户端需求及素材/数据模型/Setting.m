//
//  Setting.m
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/14.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import "Setting.h"

@implementation Setting
static Setting *instance;

@synthesize pageSize;

+ (Setting *)sharedInstance{
    if (!instance) {
        instance = [[Setting alloc]init];
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

- (id)init{
    if (self = [super init]) {
        //设置默认值
        pageSize = 15;
    }
    return self;
}
@end
