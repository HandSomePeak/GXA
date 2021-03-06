//
//  GoodsCategory.h
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *商品类别
 */
@interface GoodsCategory : NSObject

@property (nonatomic) NSString *categoryId;     //商品ID
@property (nonatomic) NSString *categoryName;   //商品名称

- (id)initWithId:(NSString *)aId name:(NSString *)aName;
@end
