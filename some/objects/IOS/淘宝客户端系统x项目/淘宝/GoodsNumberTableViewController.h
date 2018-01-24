//
//  GoodsNumberTableViewController.h
//  淘宝
//
//  Created by gxa10 on 15/12/3.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCategory;
@interface GoodsNumberTableViewController : UITableViewController 

@property(nonatomic, copy) NSArray <UIBarButtonItem *> *rightBarButtonItems;

@property (nonatomic) GoodsCategory *goodsCategory;

@end
