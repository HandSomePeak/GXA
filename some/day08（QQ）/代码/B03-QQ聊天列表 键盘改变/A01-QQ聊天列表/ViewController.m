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

    
    //订阅通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
//键盘的位置或大小发生改变
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offsetY = frame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
    
//    NSLog(@"%@",noti.userInfo);
//    {
//        UIKeyboardAnimationCurveUserInfoKey = 7;
//        UIKeyboardAnimationDurationUserInfoKey = "0.25";
//        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
//        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
//        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
//        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
//        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
//    }
    
//    {
//        UIKeyboardAnimationCurveUserInfoKey = 7;
//        UIKeyboardAnimationDurationUserInfoKey = "0.25";
//        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
//        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 538}";
//        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 796}";
//        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
//        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
//    }
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
