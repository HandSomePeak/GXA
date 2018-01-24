//
//  MyTaoBaoViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "MyTaoBaoViewController.h"

@interface MyTaoBaoViewController ()

@end

@implementation MyTaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *message_reminder_username = NSLocalizedString(@"message_reminder_username", @"请输入用户名");
     NSString *message_reminder_password = NSLocalizedString(@"message_reminder_password", @"请输入密码");

    //提示文本
    _TextFileUserName.placeholder = message_reminder_username;
    _TextFilePassworld.placeholder = message_reminder_password;
    
    [_TextFileUserName becomeFirstResponder];
    
    //密码行显示星号
    [_TextFilePassworld setSecureTextEntry:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonLogin:(UIButton *)sender {
    NSString *prompt = NSLocalizedString(@"prompt", @"提示");
    NSString *message = NSLocalizedString(@"message", @"用户名或密码为空，请重新输入！");
    NSString *message_result = NSLocalizedString(@"message_result", @"你输入的信息为\n用户名:%@\n密码:%@");
    NSString *ok = NSLocalizedString(@"ok", @"确定");
    
    
    
    if ([_TextFileUserName.text isEqualToString:@""] || [_TextFilePassworld.text isEqualToString:@""]) {
        //创建警告器
        UIAlertController *showmenu = [UIAlertController alertControllerWithTitle:prompt message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil];
        [showmenu addAction:action];
        
        [self presentViewController:showmenu animated:YES completion:nil];
    }
    else{
        NSString *string = [NSString stringWithFormat: message_result,_TextFileUserName.text,_TextFilePassworld.text];
        //创建警告器
        UIAlertController *showmenu = [UIAlertController alertControllerWithTitle:prompt message:string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil];
        [showmenu addAction:action];
        
        [self presentViewController:showmenu animated:YES completion:nil];
        //清空用户名和密码
        _TextFileUserName.text = @"";
        _TextFilePassworld.text = @"";
    }
}

- (IBAction)return1:(UITextField *)sender {
    _TextFileUserName.text = sender.text;
}

- (IBAction)return2:(UITextField *)sender {
    _TextFilePassworld.text = sender.text;
}

- (IBAction)button:(UIButton *)sender {
    for (UIView *hide in self.view.subviews) {
        [hide resignFirstResponder];
    }
}
@end
