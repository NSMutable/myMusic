//
//  LargeMusicController.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

/***********
 以下功能待完善：
 1.切换上下一首歌等功能模块
 2.放完一首歌后不能自己切换
 3.歌词部分简单完成
 **********/

#import "LargeMusicController.h"


@interface LargeMusicController ()

@property (nonatomic ,strong) AVPlayerItem *playingItem;

//全屏的时候
@property (nonatomic, strong) UIImageView *fullView;
@property (nonatomic, strong) UILabel *songNameLabelL;
@property (nonatomic, strong) UILabel *singerNameLabelL;
@property (nonatomic, strong) UIImageView *iconImgViewL;
@property (nonatomic, strong) UIButton *playBtnL;
@property (nonatomic, strong) UISlider *sliderL;
@property (nonatomic, strong) LrcView *lrcView;
@property (nonatomic, strong) CADisplayLink *lrcTimer;

@property (nonatomic ,copy) NSMutableArray *songIdArrayM;
@property (nonatomic ,assign) NSInteger playingIndex;

@end

@implementation LargeMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLrcTimer];
    [self configUI];
}

- (void)configUI {
    self.fullView = [UIImageView new];
    [self.view addSubview:self.fullView];
    [self.fullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.fullView.image = IMAGE(@"bg_playview@2x");
    self.fullView.userInteractionEnabled = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:0];
    [self.fullView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fullView).offset(kWidth(13));
        make.top.equalTo(self.fullView).offset(kHeight(35));
        make.size.mas_equalTo(CGSizeMake(kWidth(17), kHeight(25)));
    }];
    [backBtn addTarget:self action:@selector(small) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:IMAGE(@"kglive_gift_left_arrow@2x") forState:0];
    
    self.songNameLabelL = [UILabel new];
    [self.fullView addSubview:self.songNameLabelL];
    [self.songNameLabelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fullView);
        make.top.equalTo(self.fullView).offset(kHeight(27));
        make.height.mas_equalTo(kHeight(28));
    }];
    self.songNameLabelL.text = @"随行音乐";
    self.songNameLabelL.textColor = kWhiteColor;
    self.songNameLabelL.font = k18Font;
    
    self.singerNameLabelL = [UILabel new];
    [self.fullView addSubview:self.singerNameLabelL];
    [self.singerNameLabelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fullView.mas_centerX);
        make.top.equalTo(self.songNameLabelL.mas_bottom).offset(kHeight(5));
    }];
    self.singerNameLabelL.text = @"传播好音乐";
    self.singerNameLabelL.font = k14Font;
    self.singerNameLabelL.textColor = kWhiteColor;
    
    
    self.lrcView = [LrcView new];
    [self.fullView addSubview:self.lrcView];
    [self.lrcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.singerNameLabelL.mas_bottom).offset(kHeight(20));
        make.leading.trailing.equalTo(self.fullView);
        make.bottom.equalTo(self.fullView.mas_bottom).offset(-kHeight(100));
    }];

}


- (void)addLrcTimer
{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcTimer)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)updateLrcTimer
{
    self.lrcView.currentTime = CMTimeGetSeconds(self.playingItem.currentTime);
}
- (void)removeLrcTimer
{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}


- (void)setplayerItem:(AVPlayerItem *)item musicModel:(MusicModel *)model {
    self.playingItem = item;
    self.currentMusic = model;
    [self settingView];
}
#pragma -mark 网络加载后改变视图
-(void)settingView {
    
    self.songNameLabelL.text = self.currentMusic.songName;
    self.singerNameLabelL.text = self.currentMusic.artistName;
    
    [LrcTool lrcToolDownloadWithUrl:self.currentMusic.lrcLink setUpLrcView:self.lrcView];
}

- (void)small {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
