//
//  Setting.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/14.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *软件设置类，保存软件中的设置参数，单例模式
 */
@interface Setting : NSObject

//声明变量保存我的收藏数量
//@property (nonatomic) NSInteger saveNumber;
//用于存储收藏夹的商品名称集合
@property (nonatomic) NSMutableArray *saveArray;

//声明变量保存我的购物车数量
//@property (nonatomic) NSInteger carNumber;
//用于存储购物车的商品名称集合
@property (nonatomic) NSMutableArray *carArray;
//用于保存购物车中商品的数量集合
@property (nonatomic) NSMutableArray *carArrayNumber;
//用于存数每个商品的价格
@property (nonatomic) NSMutableArray *carArrayPrice;

//保存商品列表的行数
@property (nonatomic) NSInteger pageSize;

//保存不同列的导航，用于我的收藏和我的购物车
@property (nonatomic) NSInteger select;

//获得所有列表的Indexth
@property (nonatomic) NSMutableArray *allArray;

+ (Setting *)sharedInstance;
@end
