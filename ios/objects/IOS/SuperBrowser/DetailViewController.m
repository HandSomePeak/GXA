//
//  DetailViewController.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/17.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "DetailViewController.h"
#import "SearchViewController.h"
#import "Save.h"
#import "New.h"
#import "HotNet.h"
#import "ViewController.h"

@interface DetailViewController ()
{
    //创建数组存储新闻对象
    NSMutableArray *newArray;
    //创建对象，保存每条新闻的信息
    New *new;
    //存储临时信息
    NSString *content;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    UITableViewCell *DetailTableViewCell = [[UITableViewCell alloc]init];
    [_TableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"DetailTableViewCell"];
    _TableView.dataSource = self;
    _TableView.delegate = self;
    
    //初始化数组
    newArray = [NSMutableArray array];
    
    NSLog(@"_newitem.address = %@",_newitem.address);
    //网址
    NSURL *url = [NSURL URLWithString:_newitem.address];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate = self;
    //开始解析
    [parser parse];
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
    return newArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    New *newInfo = [[New alloc]init];
    newInfo  = newArray[indexPath.row];
    UILabel *labelTitle = (UILabel *)[cell viewWithTag:1000];
    UILabel *labelTime = (UILabel *)[cell viewWithTag:1001];
    labelTitle.text = newInfo.title;
    labelTime.text = newInfo.pubDate;

    return cell;
}

#pragma mark - NSXMLParserDelgate 协议方法
//读取开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    //当标签名称等于item时，创建新的New对象
    if ([elementName isEqualToString:@"item"]) {
        new = [[New alloc]init];
    }
}
//读取结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //标签名称等于item时，对象的所有属性读取完毕
    if ([elementName isEqualToString:@"item"]) {
        [newArray addObject:new];
    }else if(![elementName isEqualToString:@"item"]){
        //为book对象的属性赋值
        if ([elementName isEqualToString:@"title"]) {
            new.title = content;
        }else if ([elementName isEqualToString:@"link"]){
            new.link = content;
        }else if ([elementName isEqualToString:@"pubDate"]){
            new.pubDate = content;
        }
    }
}

//读取标签之间的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    content = string;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SearchViewController *controllerVC = (SearchViewController *)[segue destinationViewController];
    NSIndexPath *indexPah = [_TableView indexPathForSelectedRow];
    New *newInfo = newArray[indexPah.row];
    //传送网址
    controllerVC.address = newInfo.link;
}

//返回
- (IBAction)back:(UIBarButtonItem *)sender {
    //返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
}

//主页
- (IBAction)homepage:(UIBarButtonItem *)sender {
    //跳转视图返回主页
    ViewController *homepage = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    homepage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:homepage animated:YES completion:nil];
}
@end
