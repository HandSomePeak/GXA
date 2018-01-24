//
//  HotNet.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HotNet : NSObject

//图片
@property (nonatomic) UIImage *image;
//网址
@property (nonatomic) NSString *address;
//名称
@property (nonatomic) NSString *name;

-(id)initWithName:(NSString *)name address:(NSString *)address image:(UIImage *)image;

@end
