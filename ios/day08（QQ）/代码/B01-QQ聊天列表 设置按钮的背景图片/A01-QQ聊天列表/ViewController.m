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
#import "CZMessageFrame.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

//1 懒加载
- (NSArray *)messageFrames
{
    if (_messageFrames == nil) {
        //1.1 加载模型数据
        NSArray *messages = [CZMessage messagesList];
        NSMutableArray *tmpArray = [NSMutableArray array];
        //1.2 创建frame模型
        for (CZMessage *msg in messages) {
            CZMessageFrame *msgFrame = [[CZMessageFrame alloc] init];
            msgFrame.message = msg;
            
            [tmpArray addObject:msgFrame];
        }
        _messageFrames = tmpArray;
    }
    return _messageFrames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //2 测试数据
//    NSLog(@"%@",self.messages);
    
//    self.tableView.rowHeight = 200;
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //不能选中
    self.tableView.allowsSelection = NO;
    //背景颜色
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    //全0 黑色  全255 白色
//    self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:0/255.0 alpha:1];
}

//3
#pragma mark - 数据源的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建自定义的可重用的cell
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    //2 给子控件赋值
    cell.messageFrame = self.messageFrames[indexPath.row];
    //3 返回
    return cell;
}


//返回行高
#pragma mark - tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messageFrames[indexPath.row] rowHeight];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //退出键盘
    [self.view endEditing:YES];
}









@end
