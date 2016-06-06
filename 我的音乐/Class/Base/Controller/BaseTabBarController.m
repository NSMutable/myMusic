//
//  BaseTabBarController.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//
/**********
 
 /
 /  音乐工具栏放在这个tabBar里面
 /
 
 **********/

#import "BaseTabBarController.h"
#import "NetWorkTool.h"
#import "PlayMusicTool.h"
#import "LrcView.h"
#import "LrcTool.h"
#import "LargeMusicController.h"

@interface BaseTabBarController ()
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UILabel *singerNameLabel;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic ,strong) NSTimer *progressTimer;
@property (nonatomic ,strong) AVPlayerItem *playingItem;
@property (nonatomic ,copy) NSMutableArray *songIdArrayM;
@property (nonatomic ,assign) NSInteger playingIndex;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self addProgressTimer];
}
- (void)configUI {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    [self.tabBar addSubview:view];
    view.backgroundColor = kWhiteColor;
    
    UIImageView *edgeView = [UIImageView new];
    [view addSubview:edgeView];
    [edgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(view);
        make.width.mas_equalTo(kWidth(80));
        make.height.mas_equalTo(kHeight(6));
    }];
    UIImage *img = [UIImage imageNamed:@"Playing-field_bg"];
    edgeView.image = img;
    
    UIView *underView = [UIView new];
    [view addSubview:underView];
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(edgeView.mas_bottom);
        make.trailing.leading.bottom.equalTo(view);
    }];
    underView.backgroundColor = kWhiteColor;
    
    self.iconImgView = [UIImageView new];
    self.iconImgView.layer.masksToBounds = YES;
    [view addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(kWidth(12));
        make.top.equalTo(view).offset(- kHeight(5));
        make.size.mas_equalTo(CGSizeMake(kHeight(40), kHeight(40)));
    }];
    self.iconImgView.layer.cornerRadius = kHeight(20);
    self.iconImgView.image = IMAGE(@"play_bar_singer_default");
    
    self.slider = [UISlider new];
    [underView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(kWidth(5));
        make.right.equalTo(underView.mas_right).offset(-kWidth(13));
        make.top.equalTo(underView).offset(kHeight(-2));
        make.height.mas_equalTo(kHeight(8));
    }];
    self.slider.minimumTrackTintColor = UIColorFromRGB(0xfa7e33);
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.slider setThumbImage:IMAGE(@"play_bar_sliderSmall@2x") forState:0];
    
    self.songNameLabel = [UILabel new];
    [underView addSubview:self.songNameLabel];
    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(kWidth(10));
        make.top.equalTo(self.slider.mas_bottom).offset(kHeight(1));
    }];
    self.songNameLabel.text = @"随行音乐";
    self.songNameLabel.textColor = kBlackColor;
    self.songNameLabel.font = k15Font;
    
    self.singerNameLabel = [UILabel new];
    [underView addSubview:self.singerNameLabel];
    [self.singerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.songNameLabel);
        make.bottom.equalTo(underView.mas_bottom).offset(-kHeight(2));
    }];
    self.singerNameLabel.text = @"传播好音乐";
    self.singerNameLabel.textColor = UIColorFromRGB(0xb0b0b0);
    self.singerNameLabel.font = k12Font;
    
#pragma - mark 右边的三个功能按钮
    UIButton *groupBtn = [UIButton buttonWithType:0];
    [underView addSubview:groupBtn];
    [groupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(underView.mas_right).offset(-kWidth(13));
        make.bottom.equalTo(underView.mas_bottom).offset(-kHeight(3));
        make.size.mas_equalTo(CGSizeMake(kWidth(30), kWidth(30)));
    }];
    [groupBtn setImage:IMAGE(@"playbar_yuekulist") forState:0];
    
    UIButton *nextBtn = [UIButton buttonWithType:0];
    [underView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(groupBtn.mas_left).offset(-kWidth(10));
        make.bottom.equalTo(underView.mas_bottom).offset(-kHeight(3));
        make.size.mas_equalTo(CGSizeMake(kWidth(30), kWidth(30)));
    }];
    [nextBtn setImage:IMAGE(@"playbar_new_next") forState:0];
    [nextBtn addTarget:self action:@selector(nextMusic) forControlEvents:UIControlEventTouchUpInside];
    
    self.playBtn = [UIButton buttonWithType:0];
    [underView addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playOrPauseMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextBtn.mas_left).offset(-kWidth(10));
        make.bottom.equalTo(underView.mas_bottom).offset(-kHeight(3));
        make.size.mas_equalTo(CGSizeMake(kWidth(30), kWidth(30)));
    }];
    [self.playBtn setImage:IMAGE(@"playbar_play") forState:0];
    [self.playBtn setImage:IMAGE(@"playBar_stop") forState:UIControlStateSelected];
}
#pragma -mark NSTimer
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}


#pragma -mark Slider
- (void)updateProgressTimer
{
    if (isnan(CMTimeGetSeconds(self.playingItem.duration))) {
        if (self.playingItem) {
            self.slider.maximumValue = CMTimeGetSeconds(self.playingItem.currentTime) + 1;
        }
    }
    else{
        self.slider.maximumValue = CMTimeGetSeconds(self.playingItem.duration);
    }
    
    self.slider.value = CMTimeGetSeconds(self.playingItem.currentTime);
    
    if (self.slider.value >= CMTimeGetSeconds(self.playingItem.duration) - 0.1) {
        [self nextMusic];
    }
    
}

- (void)sliderValueChanged:(UISlider *)slider
{
    if (!_playingItem) {
        return;
    }
    CMTime dragCMtime = CMTimeMake(slider.value, 1);
    [PlayMusicTool setUpCurrentPlayingTime:dragCMtime link:self.currentMusic.songLink];
}

- (void)playOrPauseMusic:(UIButton *)btn {
    if (!_playingItem) {
        return;
    }
    self.playBtn.selected = !self.playBtn.selected;
    if (self.playBtn.selected) {
        [PlayMusicTool playMusicWithLink:self.currentMusic.songLink];
    }else {
        [PlayMusicTool pauseMusicWithLink:self.currentMusic.songLink];
    }
}

- (void)nextMusic {
    if (!_playingItem) {
        return;
    }
    self.slider.value = 0;
    self.playingIndex ++;
    [NetWorkTool netWorkToolGetWithUrl:@"http://ting.baidu.com/data/music/links" parameters:@{@"songIds":self.songIdArrayM[self.playingIndex]} response:^(id response) {
        NSMutableArray *arrayM = response[@"data"][@"songList"];
        self.currentMusic = [MusicModel mj_objectWithKeyValues:arrayM.firstObject];
        [self settingSmallView];
        self.playingItem = [PlayMusicTool playMusicWithLink:self.currentMusic.songLink];
        self.playBtn.selected = YES;
    }];
}

#pragma -mark 网络加载后改变视图
-(void)settingSmallView {
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:self.currentMusic.songPicSmall]];
    self.songNameLabel.text = self.currentMusic.songName;
    self.singerNameLabel.text = self.currentMusic.artistName;
}


- (void)setSongIdArray:(NSMutableArray *)array currentIndex:(NSInteger)index {
    self.songIdArrayM = array;
    self.playingIndex = index;
    [NetWorkTool netWorkToolGetWithUrl:@"http://ting.baidu.com/data/music/links" parameters:@{@"songIds":self.songIdArrayM[self.playingIndex]} response:^(id response) {
        NSMutableArray *arrayM = response[@"data"][@"songList"];
        self.currentMusic = [MusicModel mj_objectWithKeyValues:arrayM.firstObject];
        [self settingSmallView];
        self.playingItem = [PlayMusicTool playMusicWithLink:self.currentMusic.songLink];
        self.playBtn.selected = YES;
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LargeMusicController *vc = [[LargeMusicController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        [vc setplayerItem:_playingItem musicModel:self.currentMusic];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
