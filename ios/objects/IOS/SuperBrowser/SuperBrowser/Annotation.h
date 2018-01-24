//
//  Annotation.h
//  定位和地图
//
//  Created by gxa10 on 15/12/15.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface Annotation : NSObject <MKAnnotation,MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
