//
//  CZMessageFrame.m
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import "CZMessageFrame.h"
#import "CZMessage.h"
#import "NSString+Extentsion.h"
#import <UIKit/UIKit.h>
@implementation CZMessageFrame

- (void)setMessage:(CZMessage *)message
{
    _message = message;
    
    CGFloat margin = 10;
    
    //时间
    CGFloat timeW = 375;
    CGFloat timeH = 40;
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    if (!message.isHiddenTime) {
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);

    }
    
    //头像
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconX;
    if (message.type == CZMessageTypeSelf) {
        iconX = 375 - iconW - margin;
    }else{
        iconX = margin;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //消息
    CGSize textSize = [message.text sizeOfTextFontSize:CZTextFont maxSize:CGSizeMake(200, MAXFLOAT)]; //[self sizeOfText:message.text fontSize:CZTextFont maxSize:CGSizeMake(200, MAXFLOAT)];
    
    CGSize textButtonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
    CGFloat textY = iconY;
    CGFloat textX;
    if (message.type ==  CZMessageTypeSelf) {
        textX = iconX - textButtonSize.width - margin;
    }else{
        textX = CGRectGetMaxX(_iconF) + margin;
    }
    _textF = CGRectMake(textX, textY, textButtonSize.width, textButtonSize.height);
    
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _rowHeight = MAX(textMaxY, iconMaxY) + margin;
}



@end
