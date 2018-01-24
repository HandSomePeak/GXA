//
//  Collection.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/16.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collection : NSObject

@property (nonatomic) NSInteger count;

+(Collection *)sharedInstance;

-(NSArray *)ArrayIndex:(NSInteger)index;

@end
