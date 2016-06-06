//
//  HomeView.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "HomeView.h"
#import "PublicMusictablesModel.h"
#import "ChoiceTableViewCell.h"
#import "SonglistViewController.h"


@class BaseViewController;

@interface HomeView ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *songListArray;

@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, assign) CGPoint lastOffset;

@property (nonatomic, assign) NSIndexPath *lastIndex;

@end



@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf0f0f0);
        self.lastOffset = CGPointMake(0, 0);
        [self configUI];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    
    self.songListArray = [NSMutableArray array];
    [NetWorkTool netWorkToolGetWithUrl:CMUrl parameters:CMParams(@"method":@"baidu.ting.diy.gedan",@"page_no":[NSString stringWithFormat:@"%i",1],@"page_size":@"30") response:^(id response) {
        for (NSDictionary *dict in response[@"content"]) {
            PublicMusictablesModel *tables = [PublicMusictablesModel mj_objectWithKeyValues:dict];
            [self.songListArray addObject:tables];
        }
        
        [self.tableView reloadData];
        
    }];
}

- (void)configUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.rowHeight = kHeight(350);
    [self addSubview:self.tableView];
}


#pragma - mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.songListArray[indexPath.row];
    self.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SonglistViewController *vc = [[SonglistViewController alloc] init];
    vc.listid = [self.songListArray[indexPath.row] listid];
    vc.pic = [self.songListArray[indexPath.row] pic_300];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma - mark scollerView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y > self.lastOffset.y) {
            self.lastOffset = scrollView.contentOffset;
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.indexPath.row + 1 inSection:self.indexPath.section];
            CGRect rect = [self.tableView convertRect:[self.tableView rectForRowAtIndexPath:path] toView:[self.tableView superview]];
            if (rect.origin.y < kHeight(1000) && rect.origin.y > kHeight(550)) {
                ChoiceTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                cell.transform = CGAffineTransformMakeScale((kHeight(350) - rect.origin.y + kScreenHeight - 65) / kHeight(350) , (kHeight(350) - rect.origin.y + kScreenHeight - 65) / kHeight(350));
                self.lastIndex = self.indexPath;
            }
            
        } else {
            
            self.lastOffset = scrollView.contentOffset;
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.lastIndex.row + 1 inSection:self.indexPath.section];
            CGRect rect = [self.tableView convertRect:[self.tableView rectForRowAtIndexPath:path] toView:[self.tableView superview]];
            ChoiceTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastIndex];
            if (rect.origin.y < 970) {
                cell.transform = CGAffineTransformMakeScale((kHeight(350) - rect.origin.y + kScreenHeight - 65) / kHeight(350) , (kHeight(350) - rect.origin.y + kScreenHeight - 65) / kHeight(350));
            } else {
                cell.transform = CGAffineTransformIdentity;
            }
            
            
        }
        
    }
}

@end

