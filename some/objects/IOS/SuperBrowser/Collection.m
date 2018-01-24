//
//  Collection.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "Collection.h"
#import "HotNet.h"

@interface Collection()
{
    NSArray *netarray;
}
@end

@implementation Collection
static Collection *instance;

+(Collection *)sharedInstance{
    if (!instance) {
        instance = [[Collection alloc]init];
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
        netarray = @[
            [[HotNet alloc]initWithName:@"必应" address:@"http://cn.bing.com" image:[UIImage imageNamed:@"bing"]],
            [[HotNet alloc]initWithName:@"谷歌" address:@"http://www.google.com" image:[UIImage imageNamed:@"google"]],
            [[HotNet alloc]initWithName:@"雅虎" address:@"https://www.yahoo.com" image:[UIImage imageNamed:@"yahoo"]],
            [[HotNet alloc]initWithName:@"苹果" address:@"http://www.apple.com/cn/" image:[UIImage imageNamed:@"apple"]],
                     ];
    }
    return self;
}

-(NSArray *)ArrayIndex:(NSInteger)index{
    return netarray[index];
}

- (NSInteger)count{
    return netarray.count;
}

@end
