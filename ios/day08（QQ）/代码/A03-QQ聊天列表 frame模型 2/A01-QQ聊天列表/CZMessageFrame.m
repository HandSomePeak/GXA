//
//  CZMessageFrame.m
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZMessageFrame.h"
#import "CZMessage.h"
@implementation CZMessageFrame

- (void)setMessage:(CZMessage *)message
{
    _message = message;
    
    //获取屏幕的宽度
    UIScreen *screen = [UIScreen mainScreen];
    
    CGFloat margin = 10;
    //时间的frame
    CGFloat timeW = screen.bounds.size.width;
    CGFloat timeH = 40;
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    if (!message.isHiddenTime) {
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    //头像
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconY = CGRectGetMaxY(_timeFrame);
    CGFloat iconX;
    
    if (message.type == CZMessageTypeSelf) {
        iconX = screen.bounds.size.width - iconW - margin;
    }else{
        iconX = margin;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //内容
    CGSize textSize = [self sizeWithText:message.text maxSize:CGSizeMake(250, MAXFLOAT) fontSize:CZFontSize];
    CGFloat textY = iconY;
    CGFloat textX;
    if (message.type == CZMessageTypeSelf) {
        textX = iconX - margin - textSize.width;
    }else{
        textX = CGRectGetMaxX(_iconFrame) + margin;
    }
//    _textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    _textFrame = (CGRect){{textX,textY},textSize};
    
    //计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    
    _rowHeight = MAX(iconMaxY, textMaxY) + margin;
}
// 计算文本的大小
- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


@end
