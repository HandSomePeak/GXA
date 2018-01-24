//
//  LocationViewController.h
//  SuperBrowser
//
//  Created by gxa10 on 15/12/18.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>
//文本域属性
@property (weak, nonatomic) IBOutlet UITextField *textfield;
//地图视图属性
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
//按下return键定位
- (IBAction)dingwei:(id)sender;

//返回
- (IBAction)back:(id)sender;
//天气预报属性
@property (weak, nonatomic) IBOutlet UILabel *labelWeather;

@end
