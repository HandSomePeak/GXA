//
//  MusicLibraryViewController.m
//  MusicPlayer
//
//  Created by gxa10 on 15/12/26.
//  Copyright © 2015年 gxa10. All rights reserved.
//

#import "MusicLibraryViewController.h"
#import "Music.h"
#import "MusicCollection.h"
#import "AVFoundation/AVFoundation.h"
#import "AppDelegate.h"

@interface MusicLibraryViewController ()
{
    //应用程序委托
    AppDelegate *appDelegate;
    //创建数组存储Music对象
    NSMutableArray *musicArray;
    //创建歌曲对象
    Music *music;
    //创建字符串
    NSString *content;
    //播放、下载、已下载控件
    UIButton *buttonPlay;
    UIButton *buttonDownLoad;
    UILabel *labelFinish;
    //创建对象
    Music *download;
    //用于标记播放暂停按钮
    BOOL playorpause;
    NSInteger buttonNumber;
}
@end

@implementation MusicLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    musicArray = [NSMutableArray array];
    buttonNumber = -1;
    //指定委托对象
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //获得应用程序委托对象
    appDelegate = [UIApplication sharedApplication].delegate;
    
    //获取本机web服务器地址
    NSURL *url = [NSURL URLWithString:@"http://localhost/songs.xml"];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate = self;
    //开始解析
    [parser parse];
    //创建定时器,美国一秒调用一次方法
//    [MusicCollection shartedInstance].myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(viewWillAppear:) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
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
    return musicArray.count;
}
//为表视图单元格提供数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *labelName = [cell viewWithTag:1000];
    UILabel *labelSinger = [cell viewWithTag:1001];
    buttonPlay = [cell viewWithTag:1002];
    buttonDownLoad = [cell viewWithTag:1003];
    labelFinish = [cell viewWithTag:1004];
    
    [buttonPlay setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
    [buttonDownLoad setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
    
    Music *song = musicArray[indexPath.row];
    labelName.text = song.songName;
    labelSinger.text = song.singer;
    for (Music *localSong in [MusicCollection shartedInstance].localArray) {
        if ([song.songName isEqualToString:localSong.songName] && [song.singer isEqualToString:localSong.singer]) {
            buttonDownLoad.hidden = YES;
            buttonPlay.hidden = YES;
            labelFinish.hidden = NO;
            break;
        }
        else{
            buttonDownLoad.hidden = NO;
            buttonPlay.hidden = NO;
            labelFinish.hidden = YES;
        }
    }
    
    //判断歌曲是否正在播放
    if ([song.songId isEqualToString:[MusicCollection shartedInstance].currentSong.songId]) {
        [buttonPlay setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    else{
        [buttonPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate协议方法
//响应选择表视图单元格时调用的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath = %ld",indexPath.row);
}

#pragma mark - NSXMLParserDelgate 协议方法
//读取开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    //当标签名称等于song时，创建新的Music对象
    if ([elementName isEqualToString:@"song"]) {
        music = [[Music alloc]init];
    }
}
//读取结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //标签名称等于song时，对象的所有属性读取完毕
    if ([elementName isEqualToString:@"song"]) {
        [musicArray addObject:music];
    }else{
        //为song对象的属性赋值
        if ([elementName isEqualToString:@"songId"]) {
            music.songId = content;
        }else if ([elementName isEqualToString:@"songName"]){
            music.songName = content;
        }else if ([elementName isEqualToString:@"type"]){
            music.songType = content;
        }
        else if ([elementName isEqualToString:@"singer"]){
            music.singer = content;
        }
        else if ([elementName isEqualToString:@"region"]){
            music.region = content;
        }
        else if ([elementName isEqualToString:@"link"]){
            music.link = content;
        }
    }
}

//读取标签之间的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    content = string;
}

#pragma mark - 按钮方法

- (IBAction)backBarButonItem:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentedController:(UISegmentedControl *)sender {
    
}

//下载歌曲按钮方法
- (IBAction)buttonDownLoad:(UIButton *)sender {
    NSInteger tag = [sender.titleLabel.text integerValue];
    //获取要下载歌曲的对象
    download = musicArray[tag];
    //是否在下载列表标记
    NSInteger flg = 0;
    //遍历正在下载的数组
    for (Music *start in [MusicCollection shartedInstance].startDownLoadArray) {
        //如果下载的歌曲已经在下载目录，则重复点击下载不会重复下载
        if ([start.songName isEqualToString:download.songName] && [start.singer isEqualToString:download.singer]) {
            flg = 1;
            break;
        }
    }
    //如果要下载的歌曲不在下载目录，则下载歌曲
    if ([MusicCollection shartedInstance].startDownLoadArray.count == 0 || flg == 0) {
        NSLog(@"下载歌曲: %@",download.link);
        NSString *link = [NSString stringWithFormat:@"http://localhost/%@",download.link];
        NSString *urlString = [self encodeURLString:link];
        //创建URL对象
        NSURL *url = [NSURL URLWithString:urlString];
        //需要前台显示下载进程
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
        //开始下载
        //添加对象到下载目录
        [[MusicCollection shartedInstance].startDownLoadArray addObject:download];
        //开始下载歌曲
        [downloadTask resume];
    }
}

//中文名称可用化
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

#pragma mark - NSURLSessionDownloadDelegate 协议方法
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //获取文档路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:downloadTask.currentRequest.URL.lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把下载的临时文件移到到文档目录下
    [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    //下载完成后，把歌曲添加到本地音乐并移除下载目录
    [[MusicCollection shartedInstance].localArray addObject:download];
    [[MusicCollection shartedInstance].startDownLoadArray removeObject:download];
    //在主线程中刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    //添加到数据库中
    //创建对象
    NSManagedObject *sog = [NSEntityDescription insertNewObjectForEntityForName:@"Musics" inManagedObjectContext:appDelegate.managedObjectContext];
    //添加数据
    [sog setValue:download.songName forKey:@"songName"];
    [sog setValue:download.songId forKey:@"songId"];
    [sog setValue:download.singer forKey:@"singer"];
    [sog setValue:download.songType forKey:@"songType"];
    [sog setValue:download.region forKey:@"region"];
    [sog setValue:download.link forKey:@"link"];
    //保存
    [appDelegate saveContext];
}
//下载进程
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //URLSession的下载任务处于异步队列中，更新界面必须放在主线程中
    dispatch_async(dispatch_get_main_queue(), ^{
        //进度条显示下载进度
        [MusicCollection shartedInstance].alreadyDown = totalBytesWritten;
        [MusicCollection shartedInstance].length = totalBytesExpectedToWrite;
        });
}

#pragma mark - 播放歌曲方法
- (IBAction)buttonPlay:(UIButton *)sender {
    if ([sender.titleLabel.text integerValue] != buttonNumber) {
        [MusicCollection shartedInstance].audioPlayer.currentTime = 0;
        [self.tableView reloadData];
    }
    //播放
    if ([MusicCollection shartedInstance].audioPlayer.currentTime == 0) {
        playorpause = NO;
        buttonNumber = [sender.titleLabel.text integerValue];
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        NSInteger tag = [sender.titleLabel.text integerValue];
        [MusicCollection shartedInstance].currentSong = musicArray[tag];
        NSString *str = @"/Users/gxa10/Library/Developer/CoreSimulator/Devices/7DAFA881-2B53-4F8C-B278-F83CCD0F246C/data/Containers/Bundle/Application/D5F2943E-3FAD-4122-BF17-EADA9D658AFA/AudioPlayer.app/";
        NSString *path = [NSString stringWithFormat:@"%@%@.mp3",str,[MusicCollection shartedInstance].currentSong.songName];
        NSURL *url = [NSURL fileURLWithPath:path];
        [MusicCollection shartedInstance].audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        //指定委托对象
        [MusicCollection shartedInstance].audioPlayer.delegate = self;
        [[MusicCollection shartedInstance].audioPlayer play];
    }
    //暂停
    else{
        if (playorpause == YES) {
            [[MusicCollection shartedInstance].audioPlayer play];
            [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            playorpause = NO;
        }
        else{
            [[MusicCollection shartedInstance].audioPlayer pause];
            [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            playorpause = YES;
        }
    }

}

#pragma mark - AVAudioPlayerDelegate协议方法
//音乐播放完成时,调用该方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //停止定时器
    [[MusicCollection shartedInstance].myTimer setFireDate:[NSDate distantFuture]];
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

@end
