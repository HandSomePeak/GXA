//
//  GoodsCategoryCollection.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsCategory;
/**
 *商品类别集合，实际开发时，数据来自于数据库或网络等外部资源
 *本集合使用单例模式，以保证在任何情况下数据源相同
 */
@interface GoodsCategoryCollection : NSObject
///集合长度
@property (nonatomic, readonly) NSInteger count;

///单例模式类方法
+ (GoodsCategoryCollection *)sharedInstance;
///返回指定索引处的商品类别对象
- (GoodsCategory *)goodsCategoryAtIndex:(NSInteger)index;
///返回指定范围的商品类别数组，用于分页
- (NSArray *)arrayWithRange:(NSRange)range;
///返回总页数，参数pageSize表示每页大小
- (NSInteger)pageCount:(NSInteger)pageSize;
@end
