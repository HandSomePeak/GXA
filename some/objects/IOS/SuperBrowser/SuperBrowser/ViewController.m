//
//  ViewController.m
//  超级浏览器
//
//  Created by gxa10 on 15/12/15.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "ViewController.h"
#import "Collection.h"
#import "HotNet.h"
#import "Save.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "CollectionViewController.h"
#import "LocationViewController.h"

@interface ViewController ()
{
    //屏幕宽度
    NSInteger ScreenWidth;
    //屏幕高度
    NSInteger ScreenHeigth;
    //确定行数
    NSInteger Line;
    //状态栏尺寸
    CGRect StatusBar;
    //什么标签变量。便于传送网址
    UITextField *textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取屏幕宽度和高度
    ScreenWidth = [[UIScreen mainScreen]bounds].size.width;
    ScreenHeigth = [[UIScreen mainScreen]bounds].size.height;
    //获取屏幕状态栏尺寸
    StatusBar = [[UIApplication sharedApplication] statusBarFrame];
    //初始化行数
    if ([Save sharedInstance].Array.count == 0) {
        for (int i = 0; i < [Collection sharedInstance].count; i++) {
            [[Save sharedInstance].Array addObject:[[Collection sharedInstance] ArrayIndex:i]];
        }
        Line = 1;
    }
    else{
        //每行5列
        Line = [Save sharedInstance].Array.count / 5 + 1;
    }

    
//2、创建文本域
    textField = [[UITextField alloc]initWithFrame:CGRectMake(20 + _collection.frame.size.width, 28, ScreenWidth - 2 * 20 - _collection.frame.size.width, 30)];
    textField.borderStyle =  UITextBorderStyleRoundedRect;
    textField.placeholder = @"搜索或输入网址";
    textField.clearButtonMode = YES;
    [self.view addSubview:textField];
    //为文本域指定动作方法
    [textField addTarget:self action:@selector(textfield:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(Search) forControlEvents:UIControlEventEditingDidEndOnExit];

    
//4、动态创建主页控件
    [self CreateControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{

}

#pragma mark - 文本域方法
-(void)textfield:(UITextField *)sender{
    //当第一响应在文本域时
    CGRect frame = CGRectMake(20 + _collection.frame.size.width, 28, ScreenWidth - 2 * 20 - _collection.frame.size.width - _buttoncancel.frame.size.width, 30);
    sender.frame = frame;
    //显示取消按钮
    _buttoncancel.hidden = NO;
}

#pragma mark - 动态创建主页控件
-(void)CreateControl{
//1、在滚动视图中添加控件
    //1、添加地图按钮
    UIButton *map = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, 60)];
    [map setTitle:@"城市定位和天气预报" forState:UIControlStateNormal];
    map.backgroundColor = [UIColor greenColor];
    [map addTarget:self action:@selector(gotomap:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:map];
    
//3、添加集合视图
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置对齐方式
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
     UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, map.frame.size.height, ScreenWidth, ScreenHeigth - 20 - 21 - 37 - map.frame.size.height) collectionViewLayout:flowLayout];
    UICollectionViewCell *CellCollectionViewCell = [[UICollectionViewCell alloc]init];
    [collectionView registerClass:[CellCollectionViewCell class] forCellWithReuseIdentifier:@"CellCollectionViewCell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    //添加到滚动视图
    [_scrollView addSubview:collectionView];
 
//4、添加表视图
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeigth - 20 - 21 - 37)];
    [_scrollView addSubview:tableView];
    UITableViewCell *CellTableViewCell = [[UITableViewCell alloc]init];
    [tableView registerClass:[CellTableViewCell class] forCellReuseIdentifier:@"CellTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    //5、设置滚动视图大小
    _scrollView.contentSize = CGSizeMake(2 * ScreenWidth, _scrollView.frame.size.height);
    //6、允许分页
    _scrollView.pagingEnabled = YES;
    //7、确定总页数
    _pageControl.numberOfPages = 2;
    //8、指定委托对象
    _scrollView.delegate = self;
}

//计算当前页面，用于给分页控制赋值
#pragma mack - 私有方法
-(void)loadPage{
    //获得当前页数
    int page = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    //把页数赋给分页控制控件
    _pageControl.currentPage = page;
}

/*********************************滚动视图协议方法***********************************************/

#pragma mack - UIScrollViewDelegate 委托协议
//协议中的方法，滚屏结束后自动调用此方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //调用私有方法实现当前页数的计算
    [self loadPage];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Save sharedInstance].cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    HotNet *name = [Save sharedInstance].cellArray[indexPath.row];
    cell.textLabel.text = name.name;
    return cell;
}

/*********************************表视图协议方法***********************************************/

#pragma mark - UITableViewDelegate协议方法
//表视图选择行时调用此方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转视图到表视图详细信息
    DetailViewController *controllerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //传输选择行的信息
    controllerVC.newitem = [Save sharedInstance].cellArray[indexPath.row];
    //跳转
    [self presentViewController:controllerVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource 数据源协议
//返回行数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return Line;
}
//列数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [Save sharedInstance].Array.count;
}
//为某个单元格提供显示数据
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCollectionViewCell" forIndexPath:indexPath];
    //获取数据
    HotNet *net = [Save sharedInstance].Array[indexPath.row];
    //创建视图对象
    UIImageView *imageView = [[UIImageView alloc]init];
    //创建标签对象
    UILabel *label = [[UILabel alloc]init];
    //控件位置
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetWidth(cell.frame));
    label.frame = CGRectMake(0, CGRectGetWidth(cell.frame), CGRectGetWidth(cell.frame), 20);
    //标签居中
    label.textAlignment = NSTextAlignmentCenter;
    imageView.image = net.image;
    label.text = net.name;
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    return cell;
}

/*********************************集合视图协议方法***********************************************/

#pragma mark - UICollectionViewDelegate 委托协议
//选择单元格之后触发
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转视图到表视图详细信息
    SearchViewController *controllerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    //传输选择行的信息
    HotNet *net = [Save sharedInstance].Array[indexPath.row];
    controllerVC.address = net.address;
    //跳转
    [self presentViewController:controllerVC animated:YES completion:nil];
}

#pragma mark- FlowDelegate
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 80);
}
//每个section中不同的行之间的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//定义每个Section 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{

    return UIEdgeInsetsMake(10, 10, 5, 5);//分别为上、左、下、右
}

/*********************************按钮方法***********************************************/

//取消按钮方法
- (IBAction)buttonCancel:(id)sender {
    //点击取消按钮隐藏键盘，清空文本域
    textField.text = @"";
    [textField resignFirstResponder];
     CGRect frame = CGRectMake(20 + _collection.frame.size.width, 28, ScreenWidth - 2 * 20 - _collection.frame.size.width, 30);
    textField.frame =frame;
    //隐藏取消按钮
    _buttoncancel.hidden = YES;
}

//分页控制方法
- (IBAction)pageControlAction:(UIPageControl *)sender {
    CGPoint offset = _scrollView.contentOffset;
    offset.x = sender.currentPage * _scrollView.frame.size.width;
    _scrollView.contentOffset = offset;
}

/*********************************搜索方法***********************************************/

//文本域点击Enter键进行搜索
-(void)Search{
    //点击Enter键隐藏键盘，清空文本域
    [textField resignFirstResponder];
    CGRect frame = CGRectMake(20 + _collection.frame.size.width, 28, ScreenWidth - 2 * 20 - _collection.frame.size.width, 30);
    textField.frame =frame;
    //隐藏取消按钮
    _buttoncancel.hidden = YES;
    //跳转视图实现搜索
    SearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    //传送网址
    search.address = textField.text;
    //跳转
    [self presentViewController:search animated:YES completion:nil];
}

- (IBAction)collection:(id)sender {
    //跳转视图
    CollectionViewController *collection = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    [self presentViewController:collection animated:YES completion:nil];
}

//地图跳转
-(void)gotomap:(UIButton *)sender{
    LocationViewController *location = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [self presentViewController:location animated:YES completion:nil];
}


@end













