//
//  LrcView.m
//  随行之声
//
//  Created by 陈淼 on 16/6/2.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "LrcView.h"
#import "LrcCell.h"
#import "LrcModel.h"

@interface LrcView ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LrcView


-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kClearColor;
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LrcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    LrcModel *lrcModel = self.lrcArray[indexPath.row];
    cell.backgroundColor = kClearColor;
    cell.lrcLabel.text = lrcModel.text;
    cell.lrcLabel.textColor = kWhiteColor;
    if (indexPath.row == self.currentIndex) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:20];
    }
    else {
        cell.lrcLabel.font = [UIFont systemFontOfSize:15];
        cell.lrcLabel.progress = 0;
    }
    return cell;
}
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    // 找出对应时间的歌词
    NSInteger count = self.lrcArray.count;
    for (NSInteger i = 0; i < count; i++) {
        LrcModel *lrcline = self.lrcArray[i];
        //下一句
        NSInteger nextIndex = i + 1;
        if (nextIndex > count - 1){
            return;
        }
        LrcModel *nextLrcline = self.lrcArray[nextIndex];
        
        //         对比两句歌词时间，处理歌曲快进的情况
        if (currentTime >= lrcline.time && currentTime < nextLrcline.time && self.currentIndex != i) {
            //          上一句
            NSMutableArray *indexs = [NSMutableArray array];
            if (self.currentIndex < count - 1) {
                NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
                [indexs addObject:previousIndexPath];
            }
            //            当前句
            self.currentIndex = i;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexs addObject:indexPath];
            
            [self.tableView reloadRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationNone];
            //            当前句居中
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        if (self.currentIndex == i) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            LrcCell *cell = (LrcCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.lrcLabel.progress = (currentTime - lrcline.time) / (nextLrcline.time - lrcline.time);
        }
    }
}


- (void)setLrcArray:(NSArray *)lrcArray
{
    _lrcArray = lrcArray;
    [self.tableView reloadData];
}


@end
