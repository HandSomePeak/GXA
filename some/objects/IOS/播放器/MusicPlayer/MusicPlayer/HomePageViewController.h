//
//  HomePageViewController.h
//  MusicPlayer
//
//  Created by gxa10 on 15/12/24.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@class GetData;
@interface HomePageViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic) GetData *getData;


//属性，搜索框
@property (weak, nonatomic) IBOutlet UITextField *textField;
//属性，本地音乐
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//属性，乐库
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMusic;
//属性，音乐电台
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMusicRedio;
//属性，显示播放歌曲窗口
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTitle;

@end
