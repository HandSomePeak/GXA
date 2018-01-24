//
//  OtherButtonViewController.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/30.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "OtherButtonViewController.h"
#import "AppDelegate.h"

@interface OtherButtonViewController ()
{
    CGRect statusBarFrame;
}
@end

@implementation OtherButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取状态栏尺寸
    statusBarFrame = [[UIApplication sharedApplication]statusBarFrame];
    //创建一个导航栏
    UINavigationBar *navigation = [[UINavigationBar alloc]initWithFrame:CGRectMake(0.0, statusBarFrame.size.height, statusBarFrame.size.width, 44)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:_navTitle];
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@" < " style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //把导航栏集合添加到导航栏中，关闭动画
    [navigation pushNavigationItem:navItem animated:NO];
    //把按钮添加到导航栏集合中
    [navItem setLeftBarButtonItem:leftButton];
    [self.view addSubview:navigation];
    //创建表视图
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, statusBarFrame.size.height + navigation.frame.size.height, statusBarFrame.size.width, [[UIScreen mainScreen]bounds].size.height - statusBarFrame.size.height - navigation.frame.size.height)];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Table View Dtae Sources 协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//返回按钮方法
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
