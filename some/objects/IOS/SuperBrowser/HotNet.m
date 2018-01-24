//
//  HotNet.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "HotNet.h"

@implementation HotNet

-(id)initWithName:(NSString *)name address:(NSString *)address image:(UIImage *)image{
    if (self == [super init]) {
        _image = image;
        _address = address;
        _name = name;
    }
    return self;
}

@end
