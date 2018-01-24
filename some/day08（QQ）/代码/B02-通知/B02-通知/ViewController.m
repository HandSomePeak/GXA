//
//  ViewController.m
//  B02-通知
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "CZCompany.h"
#import "CZPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CZPerson *p1 = [[CZPerson alloc] init];
    p1.name = @"德山";
    
    CZPerson *p2 = [[CZPerson alloc] init];
    p2.name = @"房shi疼";
    
    CZCompany *c1 = [[CZCompany alloc] init];
    c1.name = @"三鹿";
    
    CZCompany *c2 = [[CZCompany alloc] init];
    c2.name = @"三元";
    
    
    
    
    //通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //订阅通知
    [center addObserver:p1 selector:@selector(shouniunai:) name:@"songniunai" object:nil];
    
    
    //发布通知
    //(NSString *)aName  通知的名称
    //object:(id)anObject   发布通知的对象
    //userInfo:(NSDictionary *)aUserInfo   发布通知的时候携带的参数
    [center postNotificationName:@"songniunai" object:c1 userInfo:@{@"count":@2,@"tx":@"毒牛奶在三鹿"}];
    
    
    [center postNotificationName:@"songniunai" object:c2 userInfo:@{@"count":@1,@"tx":@"好牛奶在三元"}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
