//
//  CZPerson.m
//  B02-通知
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZPerson.h"

@implementation CZPerson
- (void)shouniunai:(NSNotification *)noti
{
    NSLog(@"收到通知");
    NSLog(@"%@",noti.name);//通知的名称
    NSLog(@"%@",noti.object);//通知的发布者
    NSLog(@"%@",noti.userInfo);//参数

}

- (void)dealloc
{
    //退订
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
