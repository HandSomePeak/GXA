//
//  GoodsNumberTableViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "GoodsNumberTableViewController.h"
#import "Setting.h"

@interface GoodsNumberTableViewController ()
{
    //数据源
    NSMutableArray *searchResult;
}
@end

@implementation GoodsNumberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if ([Setting sharedInstance].select == 2) {
        //导航至我的收藏
        self.navigationItem.title = @"我的收藏";
        //创建编辑按钮
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit:)];
        //将按钮添加到导航栏
        self.navigationItem.rightBarButtonItem = editButton;
    }
    else if([Setting sharedInstance].select == 3){
        //导航至我的购物车列表
        self.navigationItem.title = @"我的购物车";
        //创建编辑按钮
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit:)];
        //为我的购物车添加付款按钮
        UIBarButtonItem *payButton = [[UIBarButtonItem alloc]initWithTitle:@"付款" style:UIBarButtonItemStylePlain target:self action:@selector(payEdit:)];
        //给按钮数组添加按钮
        _rightBarButtonItems = @[editButton,payButton];
        //将按钮添加到导航栏
        self.navigationItem.rightBarButtonItems = _rightBarButtonItems;
    }
    [self.tableView reloadData];
}

#pragma mark - 私有方法 - 编辑按钮的动作方法
//编辑按纽的动作方法
- (void)toggleEdit:(UIBarButtonItem *)sender{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    sender.title = self.tableView.editing ? @"完成" : @"编辑";
}

#pragma mark - 私有方法 - 付款按钮的动作方法
-(void)payEdit:(UIBarButtonItem *)sender{

    //商品价格统计
    NSInteger price = 0;
    for (int i = 0; i < [Setting sharedInstance].carArray.count; i++) {
        price += [[Setting sharedInstance].carArrayNumber[i] integerValue] * [[Setting sharedInstance].carArrayPrice[i] integerValue];
    }
    //提示信息
    NSString *string = [NSString stringWithFormat:@"你购买的商品合计: %ld 元",price];
    
    //创建警告器
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"付款" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    //创建按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *payAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:nil];
    
    //把按钮添加到警告器中
    [controller addAction:payAction];
    [controller addAction:action];
    
    //显示警告器
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger fig = 0;
    //选择我的收藏并且收藏夹不为空
    if([Setting sharedInstance].select == 2){
        fig = [Setting sharedInstance].saveArray.count;
    }
    //选择我的购物车并且购物车不为空
    else if ([Setting sharedInstance].select == 3 && [Setting sharedInstance].carArray.count != 0 ){
        fig = [Setting sharedInstance].carArray.count;
    }
    return fig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell5" forIndexPath:indexPath];
    //我的收藏
    if ([Setting sharedInstance].select == 2) {
        cell.userInteractionEnabled = YES;
        UILabel *label = (UILabel *)[self.tableView viewWithTag:1000];
        label.text = [NSString stringWithFormat:@"%@",[Setting sharedInstance].saveArray[indexPath.row]];
    }
    //我的购物车
    else if ( [Setting sharedInstance].select == 3 ) {
        UILabel *label1 = (UILabel *)[self.tableView viewWithTag:1000];
        label1.text = [NSString stringWithFormat:@"%@",[Setting sharedInstance].carArray[indexPath.row]];
        UILabel *label2 = (UILabel *)[self.tableView viewWithTag:1001];
        label2.text = [NSString stringWithFormat:@"%@",[Setting sharedInstance].carArrayNumber[indexPath.row]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

//编辑完成会调用此方法
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断当前状态为删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source删除数据
        //删除数据源中的数据
        if ([Setting sharedInstance].select == 2) {
            //删除收藏夹中数组中的数据
            [[Setting sharedInstance].saveArray removeObjectAtIndex:indexPath.row];
//            [Setting sharedInstance].saveNumber--;
            //删除表视图中的行
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else if ([Setting sharedInstance].select == 3) {
            //如果购物车商品数量大于1，则每删除一次，数量减少一个
            if ([[Setting sharedInstance].carArrayNumber[indexPath.row] integerValue] == 1) {
                //删除数据源中的数据
                [[Setting sharedInstance].carArray removeObjectAtIndex:indexPath.row];
                [[Setting sharedInstance].carArrayNumber removeObjectAtIndex:indexPath.row];
                [[Setting sharedInstance].carArrayPrice removeObjectAtIndex:indexPath.row];
//                [Setting sharedInstance].carNumber--;
                
                //删除表视图中的行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            else if ([[Setting sharedInstance].carArrayNumber[indexPath.row] integerValue] > 1) {
                //商品数量-1
                [Setting sharedInstance].carArrayNumber[indexPath.row] = [NSString stringWithFormat:@"%ld",[[Setting sharedInstance].carArrayNumber[indexPath.row] integerValue]-1];
                self.navigationItem.prompt = [NSString stringWithFormat:@"该商品的数量已经减少到 %ld 了",[[Setting sharedInstance].carArrayNumber[indexPath.row] integerValue]];
                UILabel *label2 = (UILabel *)[self.tableView viewWithTag:1001];
                label2.text = [NSString stringWithFormat:@"%@",[Setting sharedInstance].carArrayNumber[indexPath.row]];
                [self showPrompt];
            }
        }
    }
}

//提示信息2秒后消失
-(void)showPrompt{
    dispatch_time_t hideTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2.0 * NSEC_PER_SEC);
    dispatch_after(hideTime, dispatch_get_main_queue(), ^{
        self.navigationItem.prompt = nil;
    });
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark - UITableViewDelegate 协议方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//#pragma mark - UISearchResultsUpdating 协议方法
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//   
//    
//    //表视图重新加载数据
//    [self.tableView reloadData];
//}
//
//#pragma mark - UISearchControllerDelegate 协议方法
//- (void)didDismissSearchController:(UISearchController *)searchController{
//    
//}
//
//- (void)willDismissSearchController:(UISearchController *)searchController{
//    
//}


@end
