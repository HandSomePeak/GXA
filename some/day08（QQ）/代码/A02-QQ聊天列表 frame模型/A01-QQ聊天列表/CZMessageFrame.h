//
//  CZMessageFrame.h
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class CZMessage;
@interface CZMessageFrame : NSObject
/**
 *  此处有注释
 */
@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
/**
 *  行高
 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;
/**
 *  模型对象
 */
@property (nonatomic, strong) CZMessage *message;


@end
