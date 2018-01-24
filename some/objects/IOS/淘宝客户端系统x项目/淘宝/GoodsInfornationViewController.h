//
//  GoodsInfornationViewController.h
//  淘宝
//
//  Created by gxa10 on 15/12/2.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goods;
@interface GoodsInfornationViewController : UIViewController

@property (nonatomic) Goods *goods;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
