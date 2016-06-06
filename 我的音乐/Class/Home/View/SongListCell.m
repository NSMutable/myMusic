//
//  SongListCell.m
//  随行之声
//
//  Created by 陈淼 on 16/5/31.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "SongListCell.h"

@interface SongListCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;


@property (nonatomic, strong) UIButton *listBtn;

@end

@implementation SongListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
        _state = NO;
    }
    return self;
}

- (void)configUI {
    WS(ws);
    
    self.addBtn = [UIButton buttonWithType:0];
    [self.contentView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(kWidth(17));
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(kWidth(16), kWidth(16)));
    }];
    [self.addBtn setBackgroundImage:IMAGE(@"collectList_addSong_grey_btn") forState:0];
    
    
    
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.addBtn.mas_right).offset(kWidth(15));
        make.top.equalTo(ws.contentView).offset(kHeight(10));
    }];
    self.titleLabel.font = k15Font;
    self.titleLabel.textColor = kBlackColor;
    
    self.detailLabel = [UILabel new];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ws.titleLabel);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-kHeight(8));
    }];
    self.detailLabel.font = k12Font;
    self.detailLabel.textColor = UIColorFromRGB(0xb5b5b5);
    
    self.listBtn = [UIButton buttonWithType:0];
    [self.contentView addSubview:self.listBtn];
    [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView.mas_centerY);
        make.right.equalTo(ws.contentView.mas_right).offset(-kWidth(16));
        make.size.mas_equalTo(CGSizeMake(kWidth(24), kHeight(20)));
    }];
    [self.listBtn setBackgroundImage:IMAGE(@"audio_list_item_showmenu_press@2x") forState:0];
    [self.listBtn setBackgroundColor:kBlackColor];
}

- (void)setDetailModel:(SongListDetailModel *)detailModel {
    _detailModel = detailModel;
    self.titleLabel.text = detailModel.title;
    self.detailLabel.text = [NSString stringWithFormat:@"%@  %@", detailModel.author, detailModel.album_title];
}

#pragma - mark 两种状态下的cell
- (void)setState:(BOOL)state {
    _state = state;
    if (state == YES) {
        [self.addBtn setBackgroundImage:IMAGE(@"audio_list_item_checkBox_normal") forState:0];
        [self.addBtn setBackgroundImage:IMAGE(@"audio_list_item_checkBox_selected") forState:UIControlStateSelected];
        [self.addBtn addTarget:self action:@selector(addMusicAction) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = kGrayColor;
        self.listBtn.hidden = YES;
    }else {
        [self.addBtn setBackgroundImage:IMAGE(@"collectList_addSong_grey_btn") forState:0];
        [self.addBtn setBackgroundImage:IMAGE(@"collectList_addSong_grey_btn") forState:UIControlStateSelected];
        self.backgroundColor = kWhiteColor;
        self.listBtn.hidden = NO;
    }
   
}

- (void)addMusicAction {
    if (_state == YES) {
        self.addBtn.selected = !self.addBtn.selected;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
