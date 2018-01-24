//
//  GoodsCollection.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCollection : NSObject

@property (nonatomic, readonly) NSArray *goodsArray;

+ (GoodsCollection *)sharedInstance;
///根据商品类别编码返回商品集合
- (NSArray *)goodsForCategory:(NSString *)categoryId;
@end
