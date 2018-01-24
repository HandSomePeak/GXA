//
//  GoodsListTableViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/2.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "GoodsListTableViewController.h"
#import "GoodsCategory.h"
#import "GoodsCategoryCollection.h"
#import "GoodsCollection.h"
#import "Goods.h"
#import "GoodsInfornationViewController.h"

@interface GoodsListTableViewController ()
{
    //全部商品名称
    NSMutableArray *allName;
    //搜索到得商品名称
    NSMutableArray *selectName;
    
    UISearchController *mySearchController;
    //存放列表数据
    NSMutableArray *searchResult;
}
@end

@implementation GoodsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchResult = [NSMutableArray array];
    
    if (_from) {
        //来自商品类别,搜索结果为商品类别的商品列表数组
        searchResult = (NSMutableArray *)_array;
        self.navigationItem.title = @"商品列表";
    }
    else{
        //来自标签导航，搜索结果全部商品类别的商品列表
        self.navigationItem.title = @"淘宝搜索";
        //添加搜索栏
        mySearchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        //指定搜索栏的宽度匹配屏幕宽度
        [mySearchController.searchBar sizeToFit];
        //搜索结果显示在当前视图中，此属性值必须为NO
        mySearchController.dimsBackgroundDuringPresentation = NO;
        //指定委托对象
        mySearchController.searchResultsUpdater = self;
        mySearchController.delegate = self;
        //在表视图的页眉位置显示搜索栏
        self.tableView.tableHeaderView = mySearchController.searchBar;
        //视图加载时搜索结果等于全部内容
        searchResult = (NSMutableArray *)[GoodsCollection sharedInstance].goodsArray;
    }
    
    //初始化数组
    allName = [[NSMutableArray alloc]init];
    //循环加载商品名称号商品名称集合
    for (int i = 0; i < searchResult.count; i++) {
        Goods *goods = [GoodsCollection sharedInstance].goodsArray[i];
        [allName addObject:goods.goodsName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (searchResult.count == 0) {
        count = 1;
    }
    else{
        count = searchResult.count;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell" forIndexPath:indexPath];
    UIImageView *imagePoster = (UIImageView *)[cell viewWithTag:1000];
    UILabel *labelName = (UILabel *)[cell viewWithTag:1001];
    UILabel *labelPrice = (UILabel *)[cell viewWithTag:1002];
    
    if (_from) {
         //来自商品类别,显示商品列表
        if (searchResult.count != 0) {
            Goods *goods = searchResult[indexPath.row];
            //Cell的图片
            imagePoster.image = goods.image;
            //Cell的主标题
            labelName.text = goods.goodsName;
            //Cell的副标题
            labelPrice.text = [NSString stringWithFormat:@"热卖价：%lu",goods.price];
        }
        else{
            cell.textLabel.text = @"本类别暂无商品";
            cell.userInteractionEnabled = NO;
        }
    }
    else{
        if (searchResult.count == 0) {
            //当搜索结果不存在时
            cell.textLabel.text = @"你搜索的商品不存在";
            //行不可用
            cell.userInteractionEnabled = NO;
            //取消标志
            cell.accessoryType = NO;
        }
        else{
            cell.userInteractionEnabled = YES;
            cell.textLabel.text = @"";
            cell.accessoryType = YES;
            //来自淘宝搜索标签导航控制器
            Goods *goods = searchResult[indexPath.row];
            //Cell的图片
            imagePoster.image = goods.image;
            //Cell的主标题
            labelName.text = goods.goodsName;
            //Cell的副标题
            labelPrice.text = [NSString stringWithFormat:@"热卖价：%lu",goods.price];
        }
    }
    return cell;
}

//设置分组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_from) {
        //来自商品类别,显示标题
        NSString *string = [NSString stringWithFormat:@"%@(%ld)",_goodsCategory.categoryName,searchResult.count];
        return string;
    }
    return nil;
}

//当第一响应在搜索栏时会调用此方法
#pragma mark - UISearchResultsUpdating 协议方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //获取搜索文本
    NSString *text = searchController.searchBar.text;
    //当搜索文本为空时不清空列表
    if ([text isEqualToString:@""]) {
        return;
    }
    //创建谓词过滤对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c]%@",text];
    //把符合条件的数据存于selectName中
    selectName = [NSMutableArray arrayWithArray:[allName filteredArrayUsingPredicate:predicate]];
    //清空列表数据
    searchResult = [[NSMutableArray alloc]init];
    //查找相应商品到商品列表
    for (int i = 0; i < selectName.count; i++) {
        for (int j = 0; j < [GoodsCollection sharedInstance].goodsArray.count; j++) {
            //把商品集合中的商品依次取出
            Goods *goods = [GoodsCollection sharedInstance].goodsArray[j];
            //比较商品名称是否和目标名称相等
            if ([selectName[i] isEqualToString:goods.goodsName]) {
                //如果是要搜索的目标，则加入搜索结果数组中
                [searchResult addObject:goods];
            }
        }
    }
    //表视图重新加载数据
    [self.tableView reloadData];
}

#pragma mark - UISearchControllerDelegate 协议方法
- (void)didDismissSearchController:(UISearchController *)searchController{
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    searchResult = (NSMutableArray *)[GoodsCollection sharedInstance].goodsArray;
    //表视图重新加载数据
    [self.tableView reloadData];
}

//提示信息2秒后消失
-(void)showPrompt{
    dispatch_time_t hideTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3.0 * NSEC_PER_SEC);
    dispatch_after(hideTime, dispatch_get_main_queue(), ^{
        self.navigationItem.prompt = nil;
    });
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
//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    GoodsInfornationViewController *controllerVC = (GoodsInfornationViewController *)[segue destinationViewController];
    NSIndexPath *indexPah = [self.tableView indexPathForSelectedRow];
    controllerVC.goods = searchResult[indexPah.row];
}



@end
