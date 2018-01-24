//
//  ViewController.m
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "CZMessage.h"
#import "CZMessageCell.h"
@interface ViewController () <UITableViewDataSource>
@property (nonatomic, strong) NSArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
//1 懒加载
- (NSArray *)messages
{
    if (_messages == nil) {
        _messages = [CZMessage messagesList];
    }
    return _messages;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //2 测试数据
//    NSLog(@"%@",self.messages);
}

//3
#pragma mark - 数据源的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建自定义的可重用的cell
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    //2 给子控件赋值
    cell.message = self.messages[indexPath.row];
    //3 返回
    return cell;
}











@end
