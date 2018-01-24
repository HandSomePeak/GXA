//
//  GoodsCategoryTableViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/1.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "GoodsCategoryTableViewController.h"
#import "GoodsCategoryCollection.h"
#import "GoodsCategory.h"
#import "GoodsListTableViewController.h"
#import "Setting.h"
#import "GoodsCollection.h"

@interface GoodsCategoryTableViewController ()
{
    CGPoint offset;
    NSInteger Dimension;
    UIBarButtonItem *buttonUp;
    UIBarButtonItem *buttonDown;
}
@end


@implementation GoodsCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示的行数不包括导航栏和标签栏
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //
    offset = self.tableView.contentOffset;
    //赋初值，用于程序启动是显示下一页按钮
    Dimension = 1;
    
    //创建两个按钮
    UIBarButtonItem *up = [[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(up)];
    UIBarButtonItem *down = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(down)];
    
    //把两个按钮添加到视图
    self.navigationItem.leftBarButtonItem = up;
    self.navigationItem.rightBarButtonItem = down;
    
    buttonUp = up;
    buttonDown = down;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//重新加载改变行数后的列表
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)viewWillLayoutSubviews{
    if (offset.y == 0) {
        //默认上一页按钮隐藏
        self.navigationItem.leftBarButtonItem = nil;
    }
    if (offset.y > 0) {
        //如果不是第一页，显示上一页按钮
        self.navigationItem.leftBarButtonItem = buttonUp;
    }
    if ((NSInteger)offset.y >= Dimension) {
        //如果是最后一页，隐藏下一页按钮
        self.navigationItem.rightBarButtonItem = nil;
    }
    if ((NSInteger)offset.y < Dimension) {
        //如果不是最后一页，显示下一页按钮
        self.navigationItem.rightBarButtonItem = buttonDown;
    }
    
}

#pragma mark - 私有方法 - 上下翻页按钮
-(void)up{
    offset.y -= self.tableView.frame.size.height;
    //确定首页位置
    if (offset.y < 0) {
        offset.y = 0;
    }
    self.tableView.contentOffset = offset;
}

-(void)down{
    offset.y += self.tableView.frame.size.height;
    //确定最后一页的位置,计算每行的高度乘上行数等于总长度，再减去最后一页的高度就是最后一页的其实位置的y值
    Dimension = (NSInteger)((self.tableView.frame.size.height / [Setting sharedInstance].pageSize) * ([GoodsCategoryCollection sharedInstance].count) - self.tableView.frame.size.height);
    if (offset.y > Dimension){
        offset.y = Dimension;
    }
    self.tableView.contentOffset = offset;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //返回所有商品类型的个数76
    return [GoodsCategoryCollection sharedInstance].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建一个对象行信息
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //获得商品类别的信息
    GoodsCategory *goodsGategory = [[GoodsCategoryCollection sharedInstance] goodsCategoryAtIndex:indexPath.row];
    //向控件传递数据
    cell.imageView.image = [UIImage imageNamed:@"tao"];
    cell.textLabel.text = goodsGategory.categoryName;
    return cell;
}

//设置手机屏幕上显示的行数，用屏幕高度除以每页行数。
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height / [Setting sharedInstance].pageSize;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//通过Segue显示下一个视图时会调用此方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获得目标视图控制器
    GoodsListTableViewController *collectionVC = (GoodsListTableViewController *)[segue destinationViewController];
    //获得用户点击的表视图的行
    NSIndexPath *indexPah = [self.tableView indexPathForSelectedRow];
    //获得商品类别
    collectionVC.goodsCategory = [[GoodsCategoryCollection sharedInstance] goodsCategoryAtIndex:indexPah.row];
    //根据该行的商品类别，找到商品列表
    collectionVC.array = [[GoodsCollection sharedInstance] goodsForCategory:[[GoodsCategoryCollection sharedInstance] goodsCategoryAtIndex:indexPah.row].categoryId];
    //判定来自商品类别
    collectionVC.from = YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


@end
