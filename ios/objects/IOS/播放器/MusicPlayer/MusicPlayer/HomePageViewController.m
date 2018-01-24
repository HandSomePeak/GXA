//
//  HomePageViewController.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/24.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "HomePageViewController.h"
#import "MusicCollection.h"
#import "LocalMusicsViewController.h"
#import "MusicLibraryViewController.h"
#import "Music.h"
#import "AVFoundation/AVFoundation.h"
#import "AppDelegate.h"
#import "OtherButtonViewController.h"

@interface HomePageViewController ()
{
    //创建应用程序委托对象
    AppDelegate *appDelegate;
    //屏幕尺寸
    CGRect greenFrame;
    //导航栏尺寸
    CGRect barItemFrame;
    //状态栏尺寸
    CGRect statusBarFrame;
    //本地音乐控件
    UILabel *localMusic;
    UILabel *localMusicNumber;
    UIButton *buttonPlay;
    //为乐库添加控件
    UILabel *musics;
    UILabel *category;
    UILabel *go;
    
    //播放控件
    UIButton *musicImage;
    UISlider *slider;
    UILabel *labelMusicName;
    UILabel *labelAuthorName;
    UIButton *buttonUp;
    UIButton *buttonPlayStop;
    UIButton *buttonNext;
    UIButton *buttonStop;
    //用于标记播放暂停按钮
    BOOL playorpause;
    
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//1、初始化
    //获取屏幕尺寸
    greenFrame = [[UIScreen mainScreen]bounds];
    //导航栏尺寸
    barItemFrame = self.navigationController.navigationBar.frame;
    //获取状态栏尺寸
    statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    //加载本地歌曲
    [self readSongName];

    //创建定时器
    [MusicCollection shartedInstance].myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(mytime) userInfo:nil repeats:YES];
    
    //获得应用程序委托对象
    appDelegate = [UIApplication sharedApplication].delegate;
//2、取出数据库中的数据
    //获得所有模型
    NSDictionary *dictionary = [appDelegate.managedObjectModel entitiesByName];
    //获取要查询的实体
    NSEntityDescription *entity = dictionary[@"Musics"];
    //创建读取对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    //指定读取对象的目标实体
    fetchRequest.entity = entity;
    NSArray *songs = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [MusicCollection shartedInstance].localArray = [NSMutableArray arrayWithArray:songs];
    
//3、显示播放信息的滚动视图
    _scrollViewTitle.backgroundColor = [UIColor whiteColor];
    //添加按钮显示歌曲图片
    musicImage = [[UIButton alloc]initWithFrame:CGRectMake(20.0, 5.0, 34.0, 34.0)];
    [musicImage setImage:[UIImage imageNamed:@"music"] forState:UIControlStateNormal];
    [_scrollViewTitle addSubview:musicImage];
    //添加进度条显示播放进度
    slider = [[UISlider alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10.0, [[UIScreen mainScreen]bounds].size.width - 10.0 - musicImage.frame.size.width - 10.0 - 20.0, 10)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [_scrollViewTitle addSubview:slider];
    //添加歌名标签
    labelMusicName = [[UILabel alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10 + slider.frame.size.height + 2.0, 180.0, 15.0)];
    labelMusicName.text = @"歌名";
    labelMusicName.font = [UIFont systemFontOfSize:10.0];
    [_scrollViewTitle addSubview:labelMusicName];
    //添加歌曲作者标签
    labelAuthorName = [[UILabel alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10 + slider.frame.size.height + labelMusicName.frame.size.height, 180.0, 15.0)];
    labelAuthorName.text = @"作者";
    labelAuthorName.font = [UIFont systemFontOfSize:8.0];
    labelAuthorName.textColor = [UIColor grayColor];
    [_scrollViewTitle addSubview:labelAuthorName];
    //添加上一首按钮
    buttonUp = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonUp.frame = CGRectMake(labelAuthorName.frame.origin.x + labelAuthorName.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonUp setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_scrollViewTitle addSubview:buttonUp];
    //添加播放/暂停按钮
    buttonPlayStop = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonPlayStop.frame = CGRectMake(buttonUp.frame.origin.x + buttonUp.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonPlayStop setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_scrollViewTitle addSubview:buttonPlayStop];
    //添加下一首按钮
    buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonNext.frame = CGRectMake(buttonPlayStop.frame.origin.x + buttonPlayStop.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonNext setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [_scrollViewTitle addSubview:buttonNext];
    //添加停止按钮
    buttonStop = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonStop.frame = CGRectMake(buttonNext.frame.origin.x + buttonNext.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonStop setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [_scrollViewTitle addSubview:buttonStop];

    //1、设置背景图片
    //法一:   这种方式在生成color时占用大量的内存，且不会自动拉伸（弃用）
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.png"]];
    //法二:   这种方式会自动拉伸图片，而且没有额外内存占用（推荐使用）
    UIImage *image = [UIImage imageNamed:@"1.png"];
    self.view.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    //self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //2、为本地歌曲滚动视图添加控件
    //为滚动视图添加背景颜色
    UIColor *color = [UIColor colorWithRed:16.0 green:84.0 blue:138.0 alpha:0.7];
    _scrollView.backgroundColor = color;
    _scrollViewMusic.backgroundColor = color;
    _scrollViewMusicRedio.backgroundColor = color;
    
    //1、添加本地歌曲控件
    localMusic = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, 10.0, 50, 44)];
    localMusic.text = @"本地音乐 ";
    localMusic.textColor = [UIColor blackColor];
    [localMusic sizeToFit];
    [_scrollView addSubview:localMusic];
    localMusicNumber = [[UILabel alloc]initWithFrame:CGRectMake(localMusic.frame.origin.x + localMusic.frame.size.width+ 5.0, 10.0, 100, 44)];
    NSInteger number = [MusicCollection shartedInstance].localArray.count;
    localMusicNumber.text = [NSString stringWithFormat:@"%ld首 >",number];
    localMusicNumber.font = [UIFont systemFontOfSize:13.0];
    [localMusicNumber sizeToFit];
    localMusicNumber.textColor = [UIColor grayColor];
    [_scrollView addSubview:localMusicNumber];
    //为本地音乐添加动作
    UIButton *localButton = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, 10.0, localMusic.frame.size.width + 5.0 + localMusicNumber.frame.size.width, localMusic.frame.size.height)];
    [localButton setTitle:@"" forState:UIControlStateNormal];
    [localButton addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:localButton];
    
    //2、添加播放按钮
    buttonPlay = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    buttonPlay.frame = CGRectMake(greenFrame.size.width / 1.25, 5.0, 30.0, 30.0);
    
    
    //    buttonPlay = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonPlay addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonPlay];
    
    //3、添加类型按钮和标签
    UIButton *buttonLike = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, buttonPlay.frame.size.height + 20.0, 30.0, 30.0)];
    buttonLike.backgroundColor = [UIColor blueColor];
    buttonLike.titleLabel.text =@"我喜欢";
    UILabel *labelLike = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, buttonLike.frame.origin.y + buttonLike.frame.size.height + 5.0, 30.0, 21.0)];
    labelLike.text = @"我喜欢";
    labelLike.font = [UIFont systemFontOfSize:10.0];
    labelLike.textAlignment = NSTextAlignmentCenter;
    [buttonLike addTarget:self action:@selector(jumpOthers:) forControlEvents:UIControlEventTouchUpInside];
    buttonLike.tag = 1;
    [_scrollView addSubview:labelLike];
    [_scrollView addSubview:buttonLike];
    
    UIButton *buttonMusics = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 3.5, buttonPlay.frame.size.height + 20.0, 30.0, 30.0)];
    buttonMusics.backgroundColor = [UIColor blueColor];
    buttonMusics.titleLabel.text = @"我的歌单";
    UILabel *labelMusics = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 3.5 - 10, buttonMusics.frame.origin.y + buttonMusics.frame.size.height + 5.0, 50.0, 21.0)];
    labelMusics.text = @"我的歌单";
    labelMusics.font = [UIFont systemFontOfSize:10.0];
    labelMusics.textAlignment = NSTextAlignmentCenter;
    [buttonMusics addTarget:self action:@selector(jumpOthers:) forControlEvents:UIControlEventTouchUpInside];
    buttonMusics.tag = 2;
    [_scrollView addSubview:labelMusics];
    [_scrollView addSubview:buttonMusics];
    
    UIButton *buttonDownLoad = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 1.8, buttonPlay.frame.size.height + 20.0, 30.0, 30.0)];
    buttonDownLoad.backgroundColor = [UIColor blueColor];
    buttonDownLoad.titleLabel.text = @"下载管理";
    UILabel *labelDownLoad = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 1.8 - 10, buttonDownLoad.frame.origin.y + buttonDownLoad.frame.size.height + 5.0, 50.0, 21.0)];
    labelDownLoad.text = @"下载管理";
    labelDownLoad.font = [UIFont systemFontOfSize:10.0];
    labelDownLoad.textAlignment = NSTextAlignmentCenter;
    [buttonDownLoad addTarget:self action:@selector(jumpOthers:) forControlEvents:UIControlEventTouchUpInside];
    buttonDownLoad.tag = 3;
    [_scrollView addSubview:labelDownLoad];
    [_scrollView addSubview:buttonDownLoad];
    
    UIButton *buttonRencentPlay = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 1.25, buttonPlay.frame.size.height + 20.0, 30.0, 30.0)];
    buttonRencentPlay.backgroundColor = [UIColor blueColor];
    buttonRencentPlay.titleLabel.text = @"最近播放";
    UILabel *labelRencetPlay = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 1.25 - 10, buttonRencentPlay.frame.origin.y + buttonRencentPlay.frame.size.height + 5.0, 50.0, 21.0)];
    labelRencetPlay.text = @"最近播放";
    labelRencetPlay.font = [UIFont systemFontOfSize:10.0];
    labelRencetPlay.textAlignment = NSTextAlignmentCenter;
    [buttonRencentPlay addTarget:self action:@selector(jumpOthers:) forControlEvents:UIControlEventTouchUpInside];
    buttonRencentPlay.tag = 4;
    [_scrollView addSubview:labelRencetPlay];
    [_scrollView addSubview:buttonRencentPlay];
    
    //3、为乐库滚动视图添加控件
    musics = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, 20.0, 150.0 , 21.0)];
    musics.text = @"乐库";
    [_scrollViewMusic addSubview:musics];
    category = [[UILabel alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, musics.frame.origin.y + musics.frame.size.height, 150.0 , 21.0)];
    category.text = @"排行榜|歌手|歌单|分类";
    category.font = [UIFont systemFontOfSize:10.0];
    category.textColor = [UIColor grayColor];
    [_scrollViewMusic addSubview:category];
    go = [[UILabel alloc]initWithFrame:CGRectMake(category.frame.origin.x + category.frame.size.width, _scrollViewMusic.frame.size.height / 2.0 - 10.0, 20.0 , 21.0)];
    go.text = @" > ";
    [_scrollViewMusic addSubview:go];
    UIButton *musicLibrary = [[UIButton alloc]initWithFrame:CGRectMake(greenFrame.size.width / 25.0, 20.0, musics.frame.origin.x + category.frame.size.width + go.frame.size.width, musics.frame.size.height + category.frame.size.height)];
    [musicLibrary setTitle:@"" forState:UIControlStateNormal];
    [musicLibrary addTarget:self action:@selector(jumpLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewMusic addSubview:musicLibrary];
    
    //4、为音乐电台添加控件
    UIButton *buttonMusicRadio = [[UIButton alloc]initWithFrame:CGRectMake((_scrollViewMusicRedio.frame.size.width - 30.0) / 2 , 20.0, 30.0, 30.0)];
    buttonMusicRadio.backgroundColor = [UIColor blueColor];
    buttonMusicRadio.titleLabel.text = @"音乐电台";
    [buttonMusicRadio addTarget:self action:@selector(jumpOthers:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labelRadio = [[UILabel alloc]initWithFrame:CGRectMake((_scrollViewMusicRedio.frame.size.width - 30.0) / 2 -10 , buttonMusicRadio.frame.origin.y + buttonMusicRadio.frame.size.height, 50.0, 21.0)];
    labelRadio.text = @"音乐电台";
    labelRadio.font = [UIFont systemFontOfSize:10.0];
    labelRadio.textAlignment = NSTextAlignmentCenter;
    [_scrollViewMusicRedio addSubview:labelRadio];
    [_scrollViewMusicRedio addSubview:buttonMusicRadio];
    
    //5、设置搜索框背景颜色
    _textField.backgroundColor = color;
    _textField.placeholder = @"搜索歌曲/歌星";
    
    
    //6、为控件指定方法
    [buttonUp addTarget:self action:@selector(upMusic:) forControlEvents:UIControlEventTouchUpInside];
    [buttonPlayStop addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [buttonNext addTarget:self action:@selector(nextMusic:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(slider) forControlEvents:UIControlEventValueChanged];
    [buttonStop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //加载滑块值、歌名、歌手等
    slider.value = [MusicCollection shartedInstance].audioPlayer.currentTime / [MusicCollection shartedInstance].audioPlayer.duration;
    labelMusicName.text = [MusicCollection shartedInstance].currentSong.songName;
    labelAuthorName.text = [MusicCollection shartedInstance].currentSong.singer;
    
    localMusicNumber.text = [NSString stringWithFormat:@"%ld首 >",[MusicCollection shartedInstance].localArray.count];
    localMusicNumber.textColor = [UIColor blackColor];
    localMusic.textColor = [UIColor blackColor];
    
    musics.textColor = [UIColor blackColor];
    category.textColor = [UIColor blackColor];
    go.textColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
- (void)readSongName{
    //file:/ttt/tt/file.mp3
    NSMutableArray *allSongs = [NSMutableArray array];
    NSArray *paths = [[NSBundle mainBundle]pathsForResourcesOfType:@"mp3" inDirectory:nil];
    for (NSString *path in paths) {
        NSURL *url = [NSURL fileURLWithPath:path];
        NSString *filename = [url lastPathComponent];
        filename = [filename substringToIndex:[filename rangeOfString:@"."].location];
        [allSongs addObject:filename];
    }
    [MusicCollection shartedInstance].localArray = allSongs;
}

#pragma mark - 本地音乐跳转
-(void)jump:(UIButton *)sender{
    UIColor *color = [UIColor blueColor];
    localMusic.textColor = color;
    localMusicNumber.textColor = color;
//跳转到本地音乐界面
    LocalMusicsViewController *contrlloerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LocalMusicsViewController"];
    contrlloerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:contrlloerVC animated:YES completion:nil];
}

#pragma mark - 乐库跳转
-(void)jumpLibrary:(UIButton *)sender{
    UIColor *color = [UIColor blueColor];
    musics.textColor = color;
    category.textColor = color;
    go.textColor = color;
//乐库
    MusicLibraryViewController *contrlloerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicLibraryViewController"];
    contrlloerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:contrlloerVC animated:YES completion:nil];
}

#pragma mark - 跳转到其它界面
-(void)jumpOthers:(UIButton *)sender{
    OtherButtonViewController *controlerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherButtonViewController"];
    controlerVC.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    controlerVC.navTitle = sender.titleLabel.text;
    controlerVC.buttonTag = sender.tag;
    [self presentViewController:controlerVC animated:YES completion:nil];

}

//播放歌曲
-(void)play:(UIButton *)sender{
    //播放
    if ([MusicCollection shartedInstance].audioPlayer.currentTime == 0) {
        playorpause = NO;
        
        [buttonPlayStop setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [buttonPlay setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [MusicCollection shartedInstance].currentSong = [MusicCollection shartedInstance].localArray[[MusicCollection shartedInstance].row];
        labelMusicName.text = [MusicCollection shartedInstance].currentSong.songName;
        labelAuthorName.text = [MusicCollection shartedInstance].currentSong.singer;

        NSString *str = @"/Users/gxa10/Library/Developer/CoreSimulator/Devices/7DAFA881-2B53-4F8C-B278-F83CCD0F246C/data/Containers/Bundle/Application/D5F2943E-3FAD-4122-BF17-EADA9D658AFA/AudioPlayer.app/";
        NSString *path = [NSString stringWithFormat:@"%@%@.mp3",str,[MusicCollection shartedInstance].currentSong.songName];

        NSURL *url = [NSURL fileURLWithPath:path];
        [MusicCollection shartedInstance].audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        //指定委托对象
        [MusicCollection shartedInstance].audioPlayer.delegate = self;
        [[MusicCollection shartedInstance].audioPlayer play];
        //开启定时器
        [[MusicCollection shartedInstance].myTimer setFireDate:[NSDate distantPast]];
    }
    //暂停
    else{
        if (playorpause == YES) {
            [[MusicCollection shartedInstance].audioPlayer play];
            [buttonPlayStop setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            [buttonPlay setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            playorpause = NO;
        }
        else{
            [[MusicCollection shartedInstance].audioPlayer pause];
            [buttonPlayStop setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [buttonPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            playorpause = YES;
        }
    }
    
}

//下一首
-(void)nextMusic:(UIButton *)sender{
    if ([MusicCollection shartedInstance].row < [MusicCollection shartedInstance].localArray.count - 1) {
        [MusicCollection shartedInstance].row++;
        [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
        [self play:buttonPlayStop];
    }else if([MusicCollection shartedInstance].row == [MusicCollection shartedInstance].localArray.count - 1){
        //没有下一首歌时
        sender.enabled = YES;
    }
}

//上一首
-(void)upMusic:(UIButton *)sender{
    if ([MusicCollection shartedInstance].row > 0) {
        [MusicCollection shartedInstance].row--;
        [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
        [self play:buttonPlayStop];
    }else if([MusicCollection shartedInstance].row == 0){
        //没有下一首歌时
        sender.enabled = YES;
    }
}

//停止按钮方法
-(void)stop:(UIButton *)sender{
    [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
    [[MusicCollection shartedInstance].audioPlayer stop];
    [buttonPlayStop setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [buttonPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
}


//播放进度条方法
-(void)slider{
    //改变播放时间
    [MusicCollection shartedInstance].audioPlayer.currentTime = slider.value * [MusicCollection shartedInstance].audioPlayer.duration;
}

#pragma mark - AVAudioPlayerDelegate协议方法
//音乐播放完成时,调用该方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放完成");
    if ([MusicCollection shartedInstance].row < [MusicCollection shartedInstance].localArray.count - 1) {
        //播放下一首
        [MusicCollection shartedInstance].row++;
    }else if ([MusicCollection shartedInstance].row == [MusicCollection shartedInstance].localArray.count - 1){
        //当播放完本地音乐时，从头播放
        [MusicCollection shartedInstance].row = 0;
    }
    //停止定时器
    [[MusicCollection shartedInstance].myTimer setFireDate:[NSDate distantFuture]];
    [self play:buttonPlayStop];
}
// 当音频播放过程中被中断时
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    // 当音频播放过程中被中断时，执行该方法。比如：播放音频时，电话来了！
    // 这时候，音频播放将会被暂停。
    [[MusicCollection shartedInstance].audioPlayer pause];
    
}
// 当中断结束时
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    
    // AVAudioSessionInterruptionFlags_ShouldResume 表示被中断的音频可以恢复播放了。
    // 该标识在iOS 6.0 被废除。需要用flags参数，来表示视频的状态。
    //中断结束，恢复播放
    if (flags == AVAudioSessionInterruptionOptionShouldResume && player != nil) {
        [player play];
    }
}

//定时器调用方法
-(void)mytime{
    slider.value = [MusicCollection shartedInstance].audioPlayer.currentTime / [MusicCollection shartedInstance].audioPlayer.duration;
}


@end










