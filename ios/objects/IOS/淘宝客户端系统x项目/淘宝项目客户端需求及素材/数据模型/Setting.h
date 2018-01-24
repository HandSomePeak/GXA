//
//  Setting.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/14.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *软件设置类，保存软件中的设置参数，单例模式
 */
@interface Setting : NSObject

@property (nonatomic) NSInteger pageSize;

+ (Setting *)sharedInstance;
@end
