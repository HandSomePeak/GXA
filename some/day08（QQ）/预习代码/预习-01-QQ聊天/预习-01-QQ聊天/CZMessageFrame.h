//
//  CZMessageFrame.h
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#define CZTextFont 15

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class CZMessage;
@interface CZMessageFrame : NSObject
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect textF;

@property (nonatomic, assign, readonly) CGFloat rowHeight;

@property (nonatomic, strong) CZMessage *message;
@end
