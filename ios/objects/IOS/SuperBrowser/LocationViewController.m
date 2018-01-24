//
//  LocationViewController.m
//  SuperBrowser
//
//  Created by gxa10 on 15/12/18.
//  Copyright © 2015年 杨峰. All rights reserved.
//

#import "LocationViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"
#import "Annotation.h"
#import "Save.h"

@interface LocationViewController ()
{
    //创建定位服务对象
    CLLocationManager *locationManager;
    Annotation *annotation;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //文本框显示提示信息
    _textfield.placeholder = @"请输入位置信息";
    annotation = [[Annotation alloc]init];
    
    //初始化定位对象
    locationManager = [[CLLocationManager alloc]init];
    //指定委托对象
    locationManager.delegate = self;
    
    //如果当前授权状态未确定
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //请求用户授权，此方法应该和info.plist中的配置一致
        [locationManager requestWhenInUseAuthorization];
    }
    
    //定位精度
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    //定位频率，当位置发生变化时重新定位,以米为单位
    locationManager.distanceFilter = 5.0;
    //    //开始定位
    [locationManager startUpdatingLocation];
    
    //打开用户跟踪模式
    _MapView.userTrackingMode = MKUserTrackingModeFollow;
    //指定地图类型
    _MapView.mapType = MKMapTypeStandard;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate 协议方法
//定位当前位置
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //获取最后一个定位信息
    CLLocation *location = [locations lastObject];
    //创建编码器
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //反编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        //字典
        NSDictionary *address = placemark.addressDictionary;
        CLLocationCoordinate2D coordinate = placemark.location.coordinate;
        //放大地图到自身的经纬度位置。
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
        [_MapView setRegion:region animated:YES];
        //添加标注信息
        annotation.title = [address valueForKey:@"City"];
        annotation.subtitle = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
        //显示标注图标
        annotation.coordinate = coordinate;
        //加载标注
        [_MapView addAnnotation:annotation];
        
        NSString *string = [self encodeURLString:[address valueForKey:@"City"]];
        NSString *urlstring = [NSString stringWithFormat:@"http://wthrcdn.etouch.cn/weather_mini?city=%@",string];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *stringwendu = [NSString stringWithFormat:@"%@℃",[[dictionary valueForKey:@"data"] valueForKey:@"wendu"]];
        NSString *stringcity = [[dictionary valueForKey:@"data"] valueForKey:@"city"];
        _labelWeather.text = [NSString stringWithFormat:@"气温：%@ ， 城市：%@",stringwendu,stringcity];

    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)dingwei:(id)sender {
    [_textfield resignFirstResponder];
    if (![_textfield.text isEqualToString:@""]) {
        //编码
        //创建编码器
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        //指定要编码的位置信息
        [geocoder geocodeAddressString:_textfield.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks[0];
            //获取定位位置的经纬度
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            //加载定位位置
            [_MapView setCenterCoordinate:coordinate animated:YES];
            //添加标注信息
            annotation.title = _textfield.text;
            //显示标注图标
            annotation.coordinate = coordinate;
            annotation.subtitle = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
            NSLog(@"%f,%f",coordinate.longitude,coordinate.latitude);
            //加载标注
            [_MapView addAnnotation:annotation];
            //放大地图到自身的经纬度位置。
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
            [_MapView setRegion:region animated:YES];
        }];
    }

}

//把中文的城市名转换成可用的字符串
- (NSString *)encodeURLString:(NSString *)urlString{
    NSMutableCharacterSet *characterSet = (NSMutableCharacterSet *)[NSMutableCharacterSet URLFragmentAllowedCharacterSet];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLHostAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLPasswordAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLPathAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet URLUserAllowedCharacterSet]];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    return urlString;
}

@end
