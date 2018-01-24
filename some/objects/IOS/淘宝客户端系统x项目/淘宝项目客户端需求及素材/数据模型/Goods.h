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
@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *goodsName;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSString *desc;

- (id)initWithName:(NSString *)aName categoryId:(NSString *)aId image:(UIImage *)aImage price:(NSInteger)aPrice desc:(NSString *)aDesc;
@end
