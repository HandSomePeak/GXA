//
//  CZPerson.h
//  B02-通知
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZPerson : NSObject
@property (nonatomic,copy) NSString *name;

- (void)shouniunai:(NSNotification *)noti;
@end
