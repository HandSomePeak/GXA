//
//  LocalMusicsViewController.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@interface LocalMusicsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate>
//方法，返回按钮
- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender;

//循环按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
//循环方法
- (IBAction)actionCycle:(UIBarButtonItem *)sender;


//分段选择器
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//属性，表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//属性，滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
