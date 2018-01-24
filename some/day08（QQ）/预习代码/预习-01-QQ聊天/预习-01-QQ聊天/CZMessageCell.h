//
//  CZMessageCell.h
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZMessageFrame;

@interface CZMessageCell : UITableViewCell

@property (nonatomic, strong) CZMessageFrame *messageFrame;

+ (instancetype)messageCellWithTableView:(UITableView *)tableView;

@end
