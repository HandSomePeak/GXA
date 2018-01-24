//
//  CZMessageCell.m
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import "CZMessageCell.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"
#import "UIImage+Extension.h"
@interface CZMessageCell ()

@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UIButton *textView;

@end

@implementation CZMessageCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"message";
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        //时间
        UILabel *timeView = [[UILabel alloc] init];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        self.timeView.textAlignment = NSTextAlignmentCenter;
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //内容
        UIButton *textView = [[UIButton alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        textView.titleLabel.font = [UIFont systemFontOfSize:CZTextFont];
        self.textView.titleLabel.numberOfLines = 0;
        
//        textView.backgroundColor = [UIColor redColor];
        self.textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setMessageFrame:(CZMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    //1 设置子控件显示的内容
    [self setData];
    //2 设置子控件的frame
    [self setSubViewsFrame];
}

- (void)setData
{
    CZMessage *message = self.messageFrame.message;
    
    self.timeView.text = message.time;
    [self.textView  setTitle:message.text forState:UIControlStateNormal];
    if (message.type == CZMessageTypeSelf) {
        self.iconView.image = [UIImage imageNamed:@"me"];
    }else{
        self.iconView.image = [UIImage imageNamed:@"other"];
    }
    

    if (message.type == CZMessageTypeSelf) {
        [self.textView setBackgroundImage:[UIImage resizeImage:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }else{
        [self.textView setBackgroundImage:[UIImage resizeImage:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }
}


- (void)setSubViewsFrame
{
    self.timeView.frame = self.messageFrame.timeF;
    self.textView.frame = self.messageFrame.textF;
    self.iconView.frame = self.messageFrame.iconF;
}

@end
