//
//  GoodsInfornationViewController.m
//  淘宝
//
//  Created by gxa10 on 15/12/2.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "GoodsInfornationViewController.h"
#import "Goods.h"
#import "Setting.h"
#import "BuyViewController.h"

@interface GoodsInfornationViewController ()

@end

@implementation GoodsInfornationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//动态添加控件
    //一个图片
    UIImageView  *imageView = [[UIImageView alloc]initWithImage:_goods.image];
    //三个标签
    UILabel *labelName = [[UILabel alloc]init];
    UILabel *labelDes = [[UILabel alloc]init];
    UILabel *labelPrice = [[UILabel alloc]init];
    //两个按钮
    UIButton *buttoBuy = [[UIButton alloc]init];
    UIButton *buttonadd = [[UIButton alloc]init];
    //导航栏按钮
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(buttonAdd:)];
    self.navigationItem.rightBarButtonItem = button;
    
    //文本
    labelName.text = _goods.goodsName;
    labelDes.text = _goods.desc;
    labelPrice.text = [NSString stringWithFormat:@"热卖价: %ld",_goods.price];
    
    //设置按钮名称
    [buttoBuy setTitle:@"立即购买" forState:UIControlStateNormal];
    [buttonadd setTitle:@"添加到购物车" forState:UIControlStateNormal];
    //为按钮添加方法
    [buttoBuy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [buttonadd addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮字体颜色
    [buttoBuy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonadd setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    //创建图片视图位置和大小
    CGRect imageFrame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width);
    //给图片视图确定位置和大小
    imageView.frame = imageFrame;
    //将控件加载到滚动视图中
    [_scrollView addSubview:imageView];
    
    //文本1
    //创建文本域的位置和大小
    CGRect tableFrame1 = CGRectMake(0.0, imageView.frame.size.height, imageView.frame.size.width, 21);
    //给文本域确定位置和大小
    labelName.frame = tableFrame1;
    [_scrollView addSubview:labelName];
    //字体显示位置
    labelName.textAlignment = NSTextAlignmentCenter;
    
    //文本2
    CGRect tableFrame2 = CGRectMake(20.0, imageView.frame.size.height + 21, imageView.frame.size.width - 20, 21);
    labelDes.frame = tableFrame2;
    labelDes.numberOfLines = 0;
    [labelDes sizeToFit];
    [_scrollView addSubview:labelDes];
    labelDes.textAlignment = NSTextAlignmentLeft;
    
    //文本3
    CGRect tableFrame3 = CGRectMake(20.0, imageView.frame.size.height + 21 + labelDes.frame.size.height, imageView.frame.size.width - 20, 21);
    labelPrice.frame = tableFrame3;
    [_scrollView addSubview:labelPrice];
    labelPrice.textAlignment = NSTextAlignmentLeft;
    
    //按钮1
    [buttoBuy sizeToFit];
    CGRect button1 = CGRectMake((self.view.frame.size.width - buttoBuy.frame.size.width) / 2, imageView.frame.size.height + 21 + labelDes.frame.size.height + 21 , buttoBuy.frame.size.width, buttoBuy.frame.size.height);
    buttoBuy.frame = button1;
    [_scrollView addSubview:buttoBuy];
    
    //按钮2
    [buttonadd sizeToFit];
    CGRect button2 = CGRectMake((self.view.frame.size.width - buttonadd.frame.size.width) / 2, imageView.frame.size.height + 21 + labelDes.frame.size.height + 21 + buttoBuy.frame.size.height, buttonadd.frame.size.width, buttonadd.frame.size.height);
    buttonadd.frame = button2;
    [_scrollView addSubview:buttonadd];
    

    //设置滚动视图的大小
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, imageView.frame.size.height + 21 + labelDes.frame.size.height + 21 + buttoBuy.frame.size.height + buttonadd.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 私有方法 
//立即购买
-(void)buy:(UIButton *)sender{
    //实现视图翻转
    BuyViewController *coller = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    coller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:coller animated:YES completion:nil];
}
//添加到购物车
-(void)add:(UIButton *)sender{
//    NSLog(@"%ld",[Setting sharedInstance].carArray.count);
    if ([Setting sharedInstance].carArray.count == 0) {
        //把商品名称放到购物车
        [[Setting sharedInstance].carArray addObject:_goods.goodsName];
        //该商品的数量=1
        [[Setting sharedInstance].carArrayNumber addObject:@"1"];
        //添加商品的价格
        [[Setting sharedInstance].carArrayPrice addObject:[NSString stringWithFormat:@"%ld",_goods.price]];
        //弹出下拉提示信息“成功添加到购物车”
        self.navigationItem.prompt = @"成功添加到购物车";
        [self showPrompt];
    }
    else{
        BOOL isBeing = NO;  //用于标识没有找到相同的商品名称
        
        for(int i = 0;i < [Setting sharedInstance].carArray.count;i++){
            //如果要添加到购物车的商品已经在购物车中，则数量+1
            if ([[Setting sharedInstance].carArray[i] isEqualToString:_goods.goodsName]){
                isBeing = YES;  //  表示该商品已经在购物车中存在
                //该商品的数量+1
                [Setting sharedInstance].carArrayNumber[i] = [NSString stringWithFormat:@"%ld",[[Setting sharedInstance].carArrayNumber[i] integerValue]+1];
                //弹出下拉提示信息“该商品的数量已经增加”
                self.navigationItem.prompt = [NSString stringWithFormat:@"该商品的数量已经增加到 %ld ",[[Setting sharedInstance].carArrayNumber[i] integerValue]];
                [self showPrompt];
                break;
            }
        }
        //如果要添加到购物车的商品不在购物车中
        if(isBeing == NO){
            //把商品名称放到购物车
            [[Setting sharedInstance].carArray addObject:_goods.goodsName];
            //该商品的数量=1
            [[Setting sharedInstance].carArrayNumber addObject:@"1"];
            //添加商品的价格
            [[Setting sharedInstance].carArrayPrice addObject:[NSString stringWithFormat:@"%ld",_goods.price]];
            //弹出下拉提示信息“成功添加到购物车”
            self.navigationItem.prompt = @"成功添加到购物车";
            [self showPrompt];
            }
    }
}
//添加到收藏夹
-(void)buttonAdd:(UIBarButtonItem *)sender{
    if ([Setting sharedInstance].saveArray.count == 0) {
        ///把商品名称放到收藏夹
        [[Setting sharedInstance].saveArray addObject:_goods.goodsName];
        //弹出下拉提示信息“成功添加到购物车”
        self.navigationItem.prompt = @"成功添加到收藏夹";
        [self showPrompt];
    }
    else{
        BOOL isBeing = NO;  //用于标识没有找到相同的商品名称
        for(int i = 0;i < [Setting sharedInstance].saveArray.count;i++){
            if ([[Setting sharedInstance].saveArray[i] isEqualToString:_goods.goodsName]){
                isBeing =YES;
                //弹出下拉提示信息“该商品在收藏夹已经存在”
                self.navigationItem.prompt = @"该商品在收藏夹已经存在";
                [self showPrompt];
                break;
            }
        }
        //如果要添加到购物车的商品不在购物车中
        if(isBeing == NO){
            //把商品名称放到购物车
            [[Setting sharedInstance].saveArray addObject:_goods.goodsName];
            //弹出下拉提示信息“成功添加到购物车”
            self.navigationItem.prompt = @"成功添加到收藏夹";
            [self showPrompt];
        }
    }
}

//提示信息2秒后消失
-(void)showPrompt{
    dispatch_time_t hideTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.0 * NSEC_PER_SEC);
    dispatch_after(hideTime, dispatch_get_main_queue(), ^{
        self.navigationItem.prompt = nil;
    });
}



@end






