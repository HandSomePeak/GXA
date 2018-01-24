//
//  GoodsCategoryCollection.m
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import "GoodsCategoryCollection.h"
#import "GoodsCategory.h"
@interface GoodsCategoryCollection()
{
    NSArray *goodsCategories;
}

@end

@implementation GoodsCategoryCollection
static GoodsCategoryCollection *instance;

+ (GoodsCategoryCollection *)sharedInstance{
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [[GoodsCategoryCollection alloc]init];
        }
    });
    return instance;
}

- (id)init{
    if (self = [super init]) {
        //添加76条商品分类数据
        goodsCategories = @[
            [[GoodsCategory alloc]initWithId:@"001" name:@"手机"],
            [[GoodsCategory alloc]initWithId:@"002" name:@"摄影摄像"],
            [[GoodsCategory alloc]initWithId:@"003" name:@"移动影音"],
            [[GoodsCategory alloc]initWithId:@"004" name:@"热门电脑"],
            [[GoodsCategory alloc]initWithId:@"005" name:@"办公用品"],
            [[GoodsCategory alloc]initWithId:@"006" name:@"电玩/配件"],
            [[GoodsCategory alloc]initWithId:@"007" name:@"电脑硬件"],
            [[GoodsCategory alloc]initWithId:@"008" name:@"数码配件"],
            [[GoodsCategory alloc]initWithId:@"009" name:@"大家电"],
            [[GoodsCategory alloc]initWithId:@"010" name:@"环境/衣物护理"],
            [[GoodsCategory alloc]initWithId:@"011" name:@"欢乐厨房"],
            [[GoodsCategory alloc]initWithId:@"012" name:@"个人生活护理"],
            [[GoodsCategory alloc]initWithId:@"013" name:@"健康按摩"],
            [[GoodsCategory alloc]initWithId:@"014" name:@"影音及配件"],
            [[GoodsCategory alloc]initWithId:@"015" name:@"冬日衣橱"],
            [[GoodsCategory alloc]initWithId:@"016" name:@"女装热搜"],
            [[GoodsCategory alloc]initWithId:@"017" name:@"毛衣"],
            [[GoodsCategory alloc]initWithId:@"018" name:@"裤子"],
            [[GoodsCategory alloc]initWithId:@"019" name:@"特色服饰"],
            [[GoodsCategory alloc]initWithId:@"020" name:@"热卖风格"],
            [[GoodsCategory alloc]initWithId:@"021" name:@"品牌/其他"],
            [[GoodsCategory alloc]initWithId:@"022" name:@"价格"],
            [[GoodsCategory alloc]initWithId:@"023" name:@"冬装"],
            [[GoodsCategory alloc]initWithId:@"024" name:@"春秋装"],
            [[GoodsCategory alloc]initWithId:@"025" name:@"夏装"],
            [[GoodsCategory alloc]initWithId:@"026" name:@"护肤"],
            [[GoodsCategory alloc]initWithId:@"027" name:@"品质男装"],
            [[GoodsCategory alloc]initWithId:@"028" name:@"时尚休闲"],
            [[GoodsCategory alloc]initWithId:@"029" name:@"特色市场"],
            [[GoodsCategory alloc]initWithId:@"030" name:@"儿童上装"],
            [[GoodsCategory alloc]initWithId:@"031" name:@"儿童下装"],
            [[GoodsCategory alloc]initWithId:@"032" name:@"童鞋"],
            [[GoodsCategory alloc]initWithId:@"033" name:@"儿童套装"],
            [[GoodsCategory alloc]initWithId:@"034" name:@"婴幼宝贝"],
            [[GoodsCategory alloc]initWithId:@"035" name:@"儿童配饰"],
            [[GoodsCategory alloc]initWithId:@"036" name:@"女鞋款型"],
            [[GoodsCategory alloc]initWithId:@"037" name:@"女鞋热搜词"],
            [[GoodsCategory alloc]initWithId:@"038" name:@"鞋型"],
            [[GoodsCategory alloc]initWithId:@"039" name:@"尺码"],
            [[GoodsCategory alloc]initWithId:@"040" name:@"跟高"],
            [[GoodsCategory alloc]initWithId:@"041" name:@"风格"],
            [[GoodsCategory alloc]initWithId:@"042" name:@"价格"],
            [[GoodsCategory alloc]initWithId:@"043" name:@"热门品牌"],
            [[GoodsCategory alloc]initWithId:@"044" name:@"男鞋款型"],
            [[GoodsCategory alloc]initWithId:@"045" name:@"热门品牌"],
            [[GoodsCategory alloc]initWithId:@"046" name:@"价格"],
            [[GoodsCategory alloc]initWithId:@"047" name:@"男鞋热搜词"],
            [[GoodsCategory alloc]initWithId:@"048" name:@"款式"],
            [[GoodsCategory alloc]initWithId:@"049" name:@"适合人群"],
            [[GoodsCategory alloc]initWithId:@"050" name:@"文胸/内衣套装"],
            [[GoodsCategory alloc]initWithId:@"051" name:@"女士内裤"],
            [[GoodsCategory alloc]initWithId:@"052" name:@"女士内衣/睡衣"],
            [[GoodsCategory alloc]initWithId:@"053" name:@"塑身/保暖/内衣"],
            [[GoodsCategory alloc]initWithId:@"054" name:@"男士内衣专区"],
            [[GoodsCategory alloc]initWithId:@"055" name:@"美丽女袜"],
            [[GoodsCategory alloc]initWithId:@"056" name:@"女士热门品牌"],
            [[GoodsCategory alloc]initWithId:@"057" name:@"情侣必备"],
            [[GoodsCategory alloc]initWithId:@"058" name:@"女包"],
            [[GoodsCategory alloc]initWithId:@"059" name:@"男包"],
            [[GoodsCategory alloc]initWithId:@"060" name:@"品牌女包"],
            [[GoodsCategory alloc]initWithId:@"061" name:@"品牌男包"],
            [[GoodsCategory alloc]initWithId:@"062" name:@"材质/款式"],
            [[GoodsCategory alloc]initWithId:@"063" name:@"热门品牌"],
            [[GoodsCategory alloc]initWithId:@"064" name:@"休闲旅行"],
            [[GoodsCategory alloc]initWithId:@"065" name:@"休闲旅游品牌"],
            [[GoodsCategory alloc]initWithId:@"066" name:@"女士配件"],
            [[GoodsCategory alloc]initWithId:@"067" name:@"男士配件"],
            [[GoodsCategory alloc]initWithId:@"068" name:@"饰品类型"],
            [[GoodsCategory alloc]initWithId:@"069" name:@"饰品材质"],
            [[GoodsCategory alloc]initWithId:@"070" name:@"眼镜/护理用品"],
            [[GoodsCategory alloc]initWithId:@"071" name:@"烟具军刀"],
            [[GoodsCategory alloc]initWithId:@"072" name:@"珠宝材质"],
            [[GoodsCategory alloc]initWithId:@"073" name:@"珠宝类型"],
            [[GoodsCategory alloc]initWithId:@"074" name:@"手表类型"],
            [[GoodsCategory alloc]initWithId:@"075" name:@"手表品牌"],
            [[GoodsCategory alloc]initWithId:@"076" name:@"旅行用品"]
        ];
    }
    return self;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    //使用GCD实现多线程下的单例
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

- (NSInteger)count{
    return goodsCategories.count;
}

- (GoodsCategory *)goodsCategoryAtIndex:(NSInteger)index{
    return goodsCategories[index];
}

- (NSArray *)arrayWithRange:(NSRange)range{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSInteger i = range.location; i < range.length + range.location; i++) {
        if (i >= goodsCategories.count) {
            break;
        }
        [array addObject:goodsCategories[i]];
    }
    return array;
}

- (NSInteger)pageCount:(NSInteger)pageSize{
    NSInteger pageCount = goodsCategories.count / pageSize;
    return goodsCategories.count / pageSize == 0 ? pageCount : ++pageCount;
}
@end
