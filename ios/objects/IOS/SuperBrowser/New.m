//
//  New.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/17.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "New.h"

@implementation New

-(id)initWithTitle:(NSString *)title link:(NSString *)link pubDate:(NSString *)pubDate{
    if (self == [super init]) {
        _title = title;
        _link = link;
        _pubDate = pubDate;
    }
    return self;
}

@end
