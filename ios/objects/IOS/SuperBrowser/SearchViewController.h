//
//  SearchViewController.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UIWebViewDelegate>

//接收地址
@property (nonatomic) NSString *address;

//文本域属性
@property (weak, nonatomic) IBOutlet UITextField *textField;
//活动指示器属性
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
//返回属性
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItemBack;
//前进属性
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtomItemForWard;
//浏览器
@property (weak, nonatomic) IBOutlet UIWebView *webView;

//刷新按钮方法
- (IBAction)Refresh:(id)sender;
//主页方法
- (IBAction)HomePage:(UIBarButtonItem *)sender;
//收藏夹方法
- (IBAction)Collection:(UIBarButtonItem *)sender;
//导航栏返回按钮
- (IBAction)barButtonItem:(id)sender;


@end
