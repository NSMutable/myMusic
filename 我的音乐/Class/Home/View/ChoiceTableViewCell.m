//
//  ChoiceTableViewCell.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "ChoiceTableViewCell.h"

@interface ChoiceTableViewCell ()

@property (nonatomic, strong) UIImageView *picView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ChoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kWhiteColor;
        
        [self congfigUI];
    }
    return self;
}

- (void)congfigUI {
    self.picView = [UIImageView new];
    [self.contentView addSubview:self.picView];
    WS(ws);
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(ws.contentView);
        make.height.equalTo(ws.mas_height).offset(-kHeight(40));
    }];
    
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.picView.mas_bottom).offset(kHeight(10));
        make.left.equalTo(ws.contentView).offset(kWidth(15));
        make.right.equalTo(ws.contentView.mas_right).offset(-kWidth(15));
    }];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = k18Font;
}

- (void)setModel:(PublicMusictablesModel *)model {

    _model = model;
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.pic_300]];
    self.titleLabel.text = model.title;
}


- (void)setFrame:(CGRect)frame {
    frame.origin.x += 20;
    
    frame.size.width -= 2 * 20;
    
    frame.origin.y += 20;
    frame.size.height -= 2 * 20;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
