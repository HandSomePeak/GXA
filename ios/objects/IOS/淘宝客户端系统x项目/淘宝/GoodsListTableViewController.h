//
//  GoodsListTableViewController.h
//  淘宝
//
//  Created by gxa10 on 15/12/2.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCategory;
@class GoodsCollection;
@interface GoodsListTableViewController : UITableViewController <UISearchResultsUpdating, UISearchControllerDelegate>

//@property (nonatomic) NSMutableArray *selectName;

//获取商品名称和ID号
@property (nonatomic) GoodsCategory * goodsCategory;

//接收来自商品类别的商品列表数组
@property (nonatomic) NSArray *array;

//是否来自商品类别
@property (nonatomic) BOOL from;

@end
