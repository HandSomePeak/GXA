//
//  CollectionViewController.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/18.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "CollectionViewController.h"
#import "Save.h"
#import "New.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

@interface CollectionViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //指定委托对象
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //获取应用程序委托对象
    appDelegate = [UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Save sharedInstance].collectionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    New *net = [Save sharedInstance].collectionArray[indexPath.row];
    cell.textLabel.text = net.title;
    return cell;
}
#pragma mark - UITableViewDelegate协议方法
//表视图选择行时调用此方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转视图到表视图详细信息
    SearchViewController *controllerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    //传输选择行的信息
    New *net = [Save sharedInstance].collectionArray[indexPath.row];
    controllerVC.address = net.link;
    //跳转
    [self presentViewController:controllerVC animated:YES completion:nil];
}

//返回按钮方法
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//编辑按钮方法
- (IBAction)edit:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    _edit.title = self.tableView.editing ? @"完成" : @"编辑";
}

//编辑完成会调用此方法
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断当前状态为删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
// Delete the row from the data source删除数据
        //获得所有模型
        NSDictionary *dictionary = [appDelegate.managedObjectModel entitiesByName];
        //获取要查询的实体
        NSEntityDescription *entity = dictionary[@"New"];
        //创建读取对象
        NSFetchRequest *fetchReuqest = [[NSFetchRequest alloc]init];
        New *bo = [Save sharedInstance].collectionArray[indexPath.row];
        //创建谓词查询对象
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", bo.title];
        //指定读取对象的目标实体
        fetchReuqest.entity = entity;
        //指定查询条件
        fetchReuqest.predicate = predicate;
        NSArray *news = [appDelegate.managedObjectContext executeFetchRequest:fetchReuqest error:nil];
        for (NSManagedObject *new in news) {
            //删除该商品
            [appDelegate.managedObjectContext deleteObject:new];
        }
        //保存
        [appDelegate saveContext];

        //删除数组中的数据
        [[Save sharedInstance].collectionArray removeObjectAtIndex:indexPath.row];
        //删除表视图中的行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end











