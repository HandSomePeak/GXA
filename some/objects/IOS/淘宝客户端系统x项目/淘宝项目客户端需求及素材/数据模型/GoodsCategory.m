//
//  GoodsCategory.m
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import "GoodsCategory.h"

@implementation GoodsCategory
@synthesize categoryId, categoryName;

- (id)initWithId:(NSString *)aId name:(NSString *)aName{
    if (self = [super init]) {
        categoryId = aId;
        categoryName = aName;
    }
    return self;
}
@end
