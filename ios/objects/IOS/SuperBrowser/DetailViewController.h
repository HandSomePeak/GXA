//
//  DetailViewController.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/17.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotNet;
@interface DetailViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) HotNet *newitem;
//表视图属性
@property (weak, nonatomic) IBOutlet UITableView *TableView;
//上一页方法
- (IBAction)back:(UIBarButtonItem *)sender;
//主页
- (IBAction)homepage:(UIBarButtonItem *)sender;
@end
