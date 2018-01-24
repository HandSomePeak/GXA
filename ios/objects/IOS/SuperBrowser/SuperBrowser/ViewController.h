//
//  ViewController.h
//  超级浏览器
//
//  Created by gxa10 on 15/12/15.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>
//分页控件属性
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
//滚动视图属性
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//取消按钮方法
- (IBAction)buttonCancel:(id)sender;
//取消按钮属性
@property (weak, nonatomic) IBOutlet UIButton *buttoncancel;
//收藏夹
- (IBAction)collection:(id)sender;
//收藏夹属性
@property (weak, nonatomic) IBOutlet UIButton *collection;

//分页控件方法
- (IBAction)pageControlAction:(UIPageControl *)sender;

@end

