//
//  Goods.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Goods : NSObject

//商品信息
@property (nonatomic) NSString *categoryId; //商品ID
@property (nonatomic) NSString *goodsName;  //商品名称
@property (nonatomic) UIImage *image;       //商品照片
@property (nonatomic) NSInteger price;      //商品价格
@property (nonatomic) NSString *desc;       //商品描述

- (id)initWithName:(NSString *)aName categoryId:(NSString *)aId image:(UIImage *)aImage price:(NSInteger)aPrice desc:(NSString *)aDesc;
@end
