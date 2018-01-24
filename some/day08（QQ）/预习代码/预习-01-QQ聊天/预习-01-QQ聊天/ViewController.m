//
//  ViewController.m
//  预习-01-QQ聊天
//
//  Created by js on 14/11/28.
//  Copyright (c) 2014年 czbk. All rights reserved.
//

#import "ViewController.h"

#import "CZMessage.h"
#import "CZMessageFrame.h"
#import "CZMessageCell.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        
        NSArray *messages = [CZMessage messagesList];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (CZMessage *message in messages) {
            CZMessageFrame *frame = [[CZMessageFrame alloc] init];
            frame.message = message;
            [tmpArray addObject:frame];
        }
        _messageFrames = tmpArray;
    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

    
    //订阅键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWiddChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWiddChangeFrame:(NSNotification *)noti
{
    
    CGRect keyboardFrameEnd = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat  duration = [noti.userInfo[@""] floatValue];
    
    CGFloat y = keyboardFrameEnd.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, y);
    }];
    
    
    
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

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    cell.messageFrame = self.messageFrames[indexPath.row];
    
    return cell;
}

#pragma mark - tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CZMessageFrame *frame = self.messageFrames[indexPath.row];
    return frame.rowHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
//文本框的代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMsg:textField.text messageType:CZMessageTypeSelf];
    
    [self sendMsg:@"滚" messageType:CZMessageTypeOther];

    return YES;
}

- (void)sendMsg:(NSString *)text messageType:(CZMessageType)type
{
    CZMessageFrame *frame = [[CZMessageFrame alloc] init];

    CZMessage *msg = [[CZMessage alloc] init];
    msg.type = type;
    msg.text = text;
    
    //获取当前时间
    NSDate *date = [NSDate date];
    //格式化日期对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    
    msg.time = [formatter stringFromDate:date];
    
    
    //判断当前消息的时间和上一次消息的时间是否一样
    CZMessageFrame *lastMsgFrame = [self.messageFrames lastObject];
    CZMessage *lastMsg = lastMsgFrame.message;
    if ([msg.time isEqualToString:lastMsg.time]) {
        msg.hiddenTime = YES;
    }
    
    
    frame.message = msg;
    [self.messageFrames addObject:frame];
    
    //刷新表格
    [self.tableView reloadData];
    
    //发完消息后滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
@end
