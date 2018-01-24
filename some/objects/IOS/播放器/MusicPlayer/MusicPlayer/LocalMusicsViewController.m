//
//  LocalMusicsViewController.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "LocalMusicsViewController.h"
#import "MusicCollection.h"
#import "Music.h"
#import "AppDelegate.h"

@interface LocalMusicsViewController ()
{
    AppDelegate *appDelegate;
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

@implementation LocalMusicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //指定委托对象
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //获得应用程序委托对象
    appDelegate = [UIApplication sharedApplication].delegate;
    //创建定时器
    [MusicCollection shartedInstance].myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(mytime) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    _scrollView.backgroundColor = [UIColor whiteColor];
    //添加按钮显示歌曲图片
    musicImage = [[UIButton alloc]initWithFrame:CGRectMake(20.0, 5.0, 34.0, 34.0)];
    [musicImage setImage:[UIImage imageNamed:@"music"] forState:UIControlStateNormal];
    [_scrollView addSubview:musicImage];
    //添加进度条显示播放进度
    slider = [[UISlider alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10.0, [[UIScreen mainScreen]bounds].size.width - 10.0 - musicImage.frame.size.width - 10.0 - 20.0, 10)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [_scrollView addSubview:slider];
    //添加歌名标签
    labelMusicName = [[UILabel alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10 + slider.frame.size.height + 2.0, 180.0, 15.0)];
    labelMusicName.text = @"歌名";
    labelMusicName.font = [UIFont systemFontOfSize:10.0];
    [_scrollView addSubview:labelMusicName];
    //添加歌曲作者标签
    labelAuthorName = [[UILabel alloc]initWithFrame:CGRectMake(20.0 + musicImage.frame.size.width +10.0, 10 + slider.frame.size.height + labelMusicName.frame.size.height, 180.0, 15.0)];
    labelAuthorName.text = @"作者";
    labelAuthorName.font = [UIFont systemFontOfSize:8.0];
    labelAuthorName.textColor = [UIColor grayColor];
    [_scrollView addSubview:labelAuthorName];
    //添加上一首按钮
    buttonUp = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonUp.frame = CGRectMake(labelAuthorName.frame.origin.x + labelAuthorName.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonUp setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_scrollView addSubview:buttonUp];
    //添加播放/暂停按钮
    buttonPlayStop = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonPlayStop.frame = CGRectMake(buttonUp.frame.origin.x + buttonUp.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonPlayStop setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_scrollView addSubview:buttonPlayStop];
    //添加下一首按钮
    buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonNext.frame = CGRectMake(buttonPlayStop.frame.origin.x + buttonPlayStop.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonNext setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [_scrollView addSubview:buttonNext];
    //添加停止按钮
    buttonStop = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonStop.frame = CGRectMake(buttonNext.frame.origin.x + buttonNext.frame.size.width + 10.0, 10.0 + slider.frame.size.height +5.0, 20.0, 20.0);
    [buttonStop setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [_scrollView addSubview:buttonStop];
    //为控件指定方法
    [buttonUp addTarget:self action:@selector(upMusic:) forControlEvents:UIControlEventTouchUpInside];
    [buttonPlayStop addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [buttonNext addTarget:self action:@selector(nextMusic:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(slider) forControlEvents:UIControlEventValueChanged];
    [buttonStop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    //加载滑块值、歌名、歌手等
    slider.value = [MusicCollection shartedInstance].audioPlayer.currentTime / [MusicCollection shartedInstance].audioPlayer.duration;
    labelMusicName.text = [MusicCollection shartedInstance].currentSong.songName;
    labelAuthorName.text = [MusicCollection shartedInstance].currentSong.singer;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source协议方法
//返回节的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//返回某个节的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MusicCollection shartedInstance].localArray.count;
}
//为表视图单元格提供数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Music *music = [MusicCollection shartedInstance].localArray[indexPath.row];
    cell.textLabel.text = music.songName;
    cell.detailTextLabel.text = music.singer;

    return cell;
}

#pragma mark - Table view Delegate协议方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Music *music = [MusicCollection shartedInstance].localArray[indexPath.row];
    //标记行
    [MusicCollection shartedInstance].row = indexPath.row;
    labelMusicName.text = music.songName;
    labelAuthorName.text = music.singer;
    [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
    //点击行时播放该首歌曲
    [self play:buttonPlayStop];
}
//删除本地音乐
//表视图的行向左滑动显示删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//删除数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    //删除数据源中的数据
        //获取所有模型
        NSDictionary *dictionary = [appDelegate.managedObjectModel entitiesByName];
        //获得要查询的实体
        NSEntityDescription *entity = dictionary[@"Musics"];
        //创建读取对象
        NSFetchRequest *fetReuqest = [[NSFetchRequest alloc]init];
        Music *music = [MusicCollection shartedInstance].localArray[indexPath.row];
        //指定谓词查询对象
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"songId = %@",music.songId];
        //指定读取对象的目标实体
        fetReuqest.entity = entity;
        //指定查询条件
        fetReuqest.predicate = predicate;
        NSArray *songs = [appDelegate.managedObjectContext executeFetchRequest:fetReuqest error:nil];
        for (NSManagedObject *song in songs) {
            [appDelegate.managedObjectContext deleteObject:song];
        }
        [appDelegate saveContext];
    //删除数组中的数据
        [[MusicCollection shartedInstance].localArray removeObjectAtIndex:indexPath.row];
        //如果删除当前播放歌曲
        if ([music.songId isEqualToString:[MusicCollection shartedInstance].currentSong.songId]) {
            [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
            [[MusicCollection shartedInstance].audioPlayer stop];
        }

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *string = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"%@/%@.mp3",string,music.songName];
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        [fileManager removeItemAtPath:path error:nil];

    }
    //删除表视图中的行
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



//播放歌曲
-(void)play:(UIButton *)sender{
    //播放
    if ([MusicCollection shartedInstance].audioPlayer.currentTime == 0) {
        playorpause = NO;
        [MusicCollection shartedInstance].currentSong = [MusicCollection shartedInstance].localArray[[MusicCollection shartedInstance].row ];
        labelMusicName.text = [MusicCollection shartedInstance].currentSong.songName;
        labelAuthorName.text = [MusicCollection shartedInstance].currentSong.singer;
        
        NSString *str = @"/Users/gxa10/Library/Developer/CoreSimulator/Devices/7DAFA881-2B53-4F8C-B278-F83CCD0F246C/data/Containers/Bundle/Application/D5F2943E-3FAD-4122-BF17-EADA9D658AFA/AudioPlayer.app/";
        NSString *path = [NSString stringWithFormat:@"%@%@.mp3",str,[MusicCollection shartedInstance].currentSong.songName];
        
        
        NSURL *url = [NSURL fileURLWithPath:path];
        [MusicCollection shartedInstance].audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        //指定委托对象
        [MusicCollection shartedInstance].audioPlayer.delegate = self;
        [[MusicCollection shartedInstance].audioPlayer play];
        
        if ([_barButtonItem.title isEqualToString:@"单曲循环"]) {
            [MusicCollection shartedInstance].audioPlayer.numberOfLoops = -1;
        }
        if([_barButtonItem.title isEqualToString:@"全部循环"]){
            [MusicCollection shartedInstance].audioPlayer.numberOfLoops = 0;
        }
        
        //开启定时器
        [[MusicCollection shartedInstance].myTimer setFireDate:[NSDate distantPast]];
    }
    //暂停
    else{
        if (playorpause == YES) {
            [[MusicCollection shartedInstance].audioPlayer play];
            playorpause = NO;
        }
        else{
            [[MusicCollection shartedInstance].audioPlayer pause];
            playorpause = YES;
        }
    }
    
}

//下一首
-(void)nextMusic:(UIButton *)sender{
    if ([MusicCollection shartedInstance].row  < [MusicCollection shartedInstance].localArray.count - 1) {
        [MusicCollection shartedInstance].row ++;
        [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
        [self play:buttonPlayStop];
    }else if([MusicCollection shartedInstance].row  == [MusicCollection shartedInstance].localArray.count - 1){
        //没有下一首歌时
        sender.enabled = YES;
    }
}

//上一首
-(void)upMusic:(UIButton *)sender{
    if ([MusicCollection shartedInstance].row  > 0) {
        [MusicCollection shartedInstance].row --;
        [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
        [self play:buttonPlayStop];
    }else if([MusicCollection shartedInstance].row  == 0){
        //没有下一首歌时
        sender.enabled = YES;
    }
}

//停止按钮方法
-(void)stop:(UIButton *)sender{
    [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
    [[MusicCollection shartedInstance].audioPlayer stop];
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
    if ([MusicCollection shartedInstance].row  < [MusicCollection shartedInstance].localArray.count - 1) {
        //播放下一首
        [MusicCollection shartedInstance].row ++;
    }else if ([MusicCollection shartedInstance].row  == [MusicCollection shartedInstance].localArray.count - 1){
        //当播放完本地音乐时，从头播放
        [MusicCollection shartedInstance].row  = 0;
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

//返回按钮方法
- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//循环播放方法
- (IBAction)actionCycle:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"单曲循环"]) {
        sender.title = @"全部循环";
    }
    else if([sender.title isEqualToString:@"全部循环"]){
        sender.title = @"单曲循环";
    }
}
@end
