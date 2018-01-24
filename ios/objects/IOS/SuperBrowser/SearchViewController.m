//
//  SearchViewController.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "SearchViewController.h"
#import "Save.h"
#import "New.h"
#import "ViewController.h"
#import "HotNet.h"
#import "AppDelegate.h"

@interface SearchViewController ()
{
    //存储临时信息
    NSString *content;
    AppDelegate *appDelegate;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //接收网址
    _textField.text = _address;
    //加载网页
    [self download];
    
    //获取应用程序委托对象
    appDelegate = [UIApplication sharedApplication].delegate;
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

-(void)download{
    //获取链接
    NSURL *url = [NSURL URLWithString:_textField.text];
    //获得请求
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    //视图加载请求
    [_webView loadRequest:urlrequest];
    //指定委托对象
    _webView.delegate = self;
    //指定后退按钮的目标
    _barButtonItemBack.target = self;
    //指定后退按钮的方法
    _barButtonItemBack.action = @selector(goback);
    
    //指定前进按钮目标
    _barButtomItemForWard.target = self;
    //指定前进按钮方法
    _barButtomItemForWard.action = @selector(goforward);
}


#pragma mark - 私有方法 - 后退按钮方法
-(void)goback{
    //网页视图加载之前的页面
    [_webView goBack];
}
#pragma mark - 私有方法 - 前进按钮方法
-(void)goforward{
    //网页视图加载下一个页面
    [_webView goForward];
}

#pragma mark - UIWebViewDelegate协议方法
//装载网页前调用
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //活动指示器开始
    [_activityView startAnimating];
}
//装载完网页后调用
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //活动指示器停止
    [_activityView stopAnimating];
    //判断是否可以后退或者前进
    _barButtonItemBack.enabled = _webView.canGoBack;
    _barButtomItemForWard.enabled = _webView.canGoForward;
}
//装载失败时调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //终止加载
    [_webView stopLoading];
}

//刷新方法
- (IBAction)Refresh:(id)sender {
    //重新加载
    [self download];
}
//收藏方法
- (IBAction)Collection:(UIBarButtonItem *)sender {
    //创建New对象
    New *webInfo = [[New alloc]init];
    //获取当前网页的标题
    webInfo.title =  [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //获得当前网页的网址
    webInfo.link =  _webView.request.URL.absoluteString;
    int flg = 0;
    //判断该网页是否已经收藏
    for (New *web in [Save sharedInstance].collectionArray) {
        if ([web.link isEqualToString:webInfo.link]) {
            break;
        }
        flg++;
    }
    //如果不存在
    if (flg == [Save sharedInstance].collectionArray.count) {
        //添加到数组
        [[Save sharedInstance].collectionArray addObject:webInfo];
//添加到数据库中
        //创建对象
        NSManagedObject *bks = [NSEntityDescription insertNewObjectForEntityForName:@"New" inManagedObjectContext:appDelegate.managedObjectContext];
        //添加数据
        [bks setValue:webInfo.title forKey:@"title"];
        [bks setValue:webInfo.link forKey:@"link"];
        [bks setValue:webInfo.pubDate forKey:@"pubdate"];
        //保存
        [appDelegate saveContext];
    }
}
//导航栏返回按钮
- (IBAction)barButtonItem:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//主页方法
- (IBAction)HomePage:(UIBarButtonItem *)sender {
    //终止加载
    [_webView stopLoading];
    //跳转视图实现搜索
    ViewController *homepage = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    homepage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:homepage animated:YES completion:nil];
}

@end










