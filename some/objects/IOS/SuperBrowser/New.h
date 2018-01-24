//
//  New.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/17.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface New : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *link;
@property (nonatomic) NSString *pubDate;

-(id)initWithTitle:(NSString *)title link:(NSString *)link pubDate:(NSString *)pubDate;

@end
