//
//  Goods.m
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import "Goods.h"

@implementation Goods
@synthesize goodsName, categoryId, image, price, desc;

- (id)initWithName:(NSString *)aName categoryId:(NSString *)aId image:(UIImage *)aImage price:(NSInteger)aPrice desc:(NSString *)aDesc{
    if (self = [super init]) {
        goodsName = aName;
        categoryId = aId;
        image = aImage;
        price = aPrice;
        desc = aDesc;
    }
    return self;
}
@end
