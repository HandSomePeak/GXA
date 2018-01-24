//
//  CollectionViewController.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/18.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//返回
- (IBAction)back:(id)sender;
//表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//编辑按钮属性
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
//编辑按钮方法
- (IBAction)edit:(id)sender;



@end
