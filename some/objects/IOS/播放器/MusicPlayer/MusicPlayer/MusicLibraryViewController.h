//
//  MusicLibraryViewController.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@interface MusicLibraryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, NSXMLParserDelegate, NSURLSessionDownloadDelegate, AVAudioPlayerDelegate>
//方法，返回按钮
- (IBAction)backBarButonItem:(UIBarButtonItem *)sender;
//分段选择器
- (IBAction)segmentedController:(UISegmentedControl *)sender;
//属性，表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//方法，下载
- (IBAction)buttonDownLoad:(UIButton *)sender;
//方法，播放
- (IBAction)buttonPlay:(UIButton *)sender;




@end
