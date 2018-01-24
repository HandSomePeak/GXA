//
//  NSString+Extentsion.m
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import "NSString+Extentsion.h"
#import <UIKit/UIKit.h>
@implementation NSString (Extentsion)
- (CGSize)sizeOfTextFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
