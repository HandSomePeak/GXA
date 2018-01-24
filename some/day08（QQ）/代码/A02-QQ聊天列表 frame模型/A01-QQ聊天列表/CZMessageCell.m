//
//  CZMessageCell.m
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZMessageCell.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"
@interface CZMessageCell ()

@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UIButton *textView;

@end

@implementation CZMessageCell

//1 创建自定义可重用cell的对象
+ (instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"msg";
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[CZMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

//2 创建子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //时间
        UILabel *timeView = [[UILabel alloc] init];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //聊天内容
        UIButton *textView = [[UIButton alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
    }
    return self;
}

//3 重写属性的setter方法
- (void)setMessageFrame:(CZMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    CZMessage *msg = messageFrame.message;
    //3.1 给子控件赋值
    self.timeView.text = msg.time;
//    if (msg.type == CZMessageTypeSelf) {
//        self.iconView.image = [UIImage imageNamed:@"me"];
//    }else{
//        self.iconView.image = [UIImage imageNamed:@"other"];
//    }
    NSString *imgName = msg.type == CZMessageTypeSelf ? @"me" : @"other";
    self.iconView.image = [UIImage imageNamed:imgName];
    
    [self.textView setTitle:msg.text forState:UIControlStateNormal];
    
    //3.2 设置子控件的frame
    self.timeView.frame = messageFrame.timeFrame;
    self.iconView.frame = messageFrame.iconFrame;
    self.textView.frame = messageFrame.textFrame;
    
}
@end
