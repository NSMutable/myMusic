//
//  SonglistViewController.m
//  随行之声
//
//  Created by 陈淼 on 16/5/30.
//  Copyright © 2016年 sijinsishui. All rights reserved.
//

#import "SonglistViewController.h"
#import "SongListModel.h"
#import "SongListDetailModel.h"
#import "SongListCell.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"

@class NetWorkTool;
@interface SonglistViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *underView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *songListArray;

@property (nonatomic, strong) NSMutableArray *songIdArray;

@property (nonatomic, strong) UIImageView *picView;

@property (nonatomic, strong) UIButton *playModelBtn;

@property (nonatomic, strong) UIButton *selectModelBtn;

//多选按钮选中前后的cell状态
@property (nonatomic, strong) NSMutableArray *cellStateArray;
//多选按钮选中后 记录cell上的按钮的状态，防止复用
@property (nonatomic, strong) NSMutableArray *cellBtnStateArray;

@end

@implementation SonglistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]   forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.alpha = 0;
    [self configUI];
}

- (void)configUI {
    
    WS(ws);
#pragma - mark 最上面的图片视图
    self.underView = [UIScrollView new];
    [self.view addSubview:self.underView];
    
    self.underView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + kHeight(215) - 64 - 64);
    self.underView.showsVerticalScrollIndicator = NO;
    self.underView.delegate = self;
    
    
    self.picView = [UIImageView new];
    [self.underView addSubview:self.picView];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.underView);
        make.leading.equalTo(ws.underView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kHeight(215));
    }];
    [self.picView sd_setImageWithURL:[NSURL URLWithString:self.pic]];
    
    
#pragma - mark 播放模式和选择view
    UIView *toolView = [UIView new];
    [self.underView addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.picView.mas_bottom);
        make.trailing.and.leading.equalTo(ws.picView);
        make.height.mas_equalTo(kHeight(45));
    }];
    
    toolView.backgroundColor = kGrayColor;
    
    self.playModelBtn = [UIButton buttonWithType:0];
    [toolView addSubview:self.playModelBtn];
    [self.playModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toolView.mas_centerY);
        make.left.equalTo(toolView.mas_left).offset(kWidth(15));
        make.height.mas_equalTo(kHeight(17));
    }];
    [self.playModelBtn setImage:IMAGE(@"顺序播放") forState:0];
    [self.playModelBtn setTitle:@"顺序播放" forState:0];
    self.playModelBtn.tag = 101;
    [self.playModelBtn addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.playModelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    self.selectModelBtn = [UIButton buttonWithType:0];
    [toolView addSubview:self.selectModelBtn];
    [self.selectModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toolView.mas_right).offset(-kWidth(15));
        make.height.and.centerY.equalTo(ws.playModelBtn);
    }];
    [self.selectModelBtn setTitle:@"多选" forState:0];
    [self.selectModelBtn addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectModelBtn.tag = 102;
    [self.selectModelBtn setTitle:@"取消" forState:UIControlStateSelected];
    [self.selectModelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    UIView *lineView = [UIView new];
    [toolView addSubview:lineView];
    lineView.backgroundColor = kWhiteColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.selectModelBtn.mas_left).offset(-kWidth(10));
        make.centerY.equalTo(ws.selectModelBtn);
        make.height.mas_equalTo(kHeight(21));
        make.width.mas_equalTo(kWidth(0.5));
    }];
    
#pragma - mark 下面的tableView
    self.tableView = [[UITableView alloc] init];
    [self.underView addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(toolView);
        make.top.equalTo(toolView.mas_bottom);
        make.height.mas_equalTo(kScreenHeight- 64 - kHeight(45) - 44);
    }];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = kHeight(56);
    
    [self.underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.bottom.equalTo(ws.tableView.mas_bottom);
    }];
}


- (void)toolBtnAction:(UIButton *)btn {
    
    if (btn.tag == 101) {
        if (self.selectModelBtn.selected == YES) {
            self.playModelBtn.selected = !self.playModelBtn.selected;
            //全选操作
            if (self.playModelBtn.selected == YES) {
                [self changeFromArray:self.cellBtnStateArray toState:YES];
            } else {
                [self changeFromArray:self.cellBtnStateArray toState:NO];
            }
        }
    }else {
        if (self.selectModelBtn.selected == NO) {
            //改变工具栏里左边按钮的样式，编程全选模式
            [self.playModelBtn setImage:IMAGE(@"audio_list_item_checkBox_normal") forState:0];
            [self.playModelBtn setTitle:@"  全选" forState:0];
            [self.playModelBtn setImage:IMAGE(@"audio_list_item_checkBox_selected") forState:UIControlStateSelected];
            [self.playModelBtn setTitle:@"  全选" forState:UIControlStateSelected];

            self.selectModelBtn.selected = YES;
            [self changeFromArray:self.cellStateArray toState:YES];
        } else {
            
            [self.playModelBtn setImage:IMAGE(@"顺序播放") forState:0];
            [self.playModelBtn setTitle:@"顺序播放" forState:0];
            [self.playModelBtn setImage:IMAGE(@"顺序播放") forState:UIControlStateSelected];
            [self.playModelBtn setTitle:@"顺序播放" forState:UIControlStateSelected];
            self.selectModelBtn.selected = NO;
            [self changeFromArray:self.cellStateArray toState:NO];

        }
        
    }
}

#pragma - mark 切换cell状态集合成一个方法
- (void)changeFromArray:(NSMutableArray *)array toState:(BOOL)state{
    NSMutableArray *seletedArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        [seletedArray addObject:[NSNumber numberWithBool:state]];
    }
    [array replaceObjectsInRange:NSMakeRange(0, array.count) withObjectsFromArray:[seletedArray copy]];
    [self.tableView reloadData];

}

#pragma - mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SongListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.detailModel = self.songListArray[indexPath.row];
    cell.state = [self.cellStateArray[indexPath.row] boolValue];
    cell.addBtn.selected = ([self.cellBtnStateArray[indexPath.row] boolValue]? UIControlStateSelected : 0);
    return cell;
}

#pragma - mark tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
    [tab setSongIdArray:self.songIdArray currentIndex:indexPath.row];
}

- (void)loadData {
    self.songListArray = [NSMutableArray array];
    self.cellStateArray = [NSMutableArray array];
    self.cellBtnStateArray = [NSMutableArray array];
    self.songIdArray = [NSMutableArray array];
    [NetWorkTool netWorkToolGetWithUrl:CMUrl parameters:CMParams(@"method":@"baidu.ting.diy.gedanInfo",@"listid":self.listid) response:^(id response) {
        SongListModel *songList = [SongListModel mj_objectWithKeyValues:response];
        
        NSInteger i = 0;
        for (NSDictionary *dict in songList.content) {
            SongListDetailModel *songDetail = [SongListDetailModel mj_objectWithKeyValues:dict];
            songDetail.num = ++i;
            [self.songListArray addObject:songDetail];
            [self.songIdArray addObject:songDetail.song_id];
            [self.cellStateArray addObject:[NSNumber numberWithBool:NO]];
            [self.cellBtnStateArray addObject:[NSNumber numberWithBool:NO]];
        }
        [self.tableView reloadData];
    }];
    
}

#pragma - mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.underView) {
        if (scrollView.contentOffset.y >= (kHeight(215) - 64 - 0.08)) {
            self.navigationController.navigationBar.alpha = 1;
            self.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y - (kHeight(215) - 64 - 0.08));
            scrollView.contentOffset = CGPointMake(0, (kHeight(215) - 64 - 0.08));
        }else {
            self.navigationController.navigationBar.alpha = 0;
            if (scrollView.contentOffset.y <= 64) {
                CGFloat y = -(scrollView.contentOffset.y - 64);
                self.picView.transform = CGAffineTransformMakeScale(1, y / kHeight(215) + 1);
            }
        }
    } else if(scrollView == self.tableView){
        
        if (self.underView.contentOffset.y < (kHeight(215) - 64 - 0.08)) {
            self.underView.contentOffset = CGPointMake(0, self.underView.contentOffset.y + scrollView.contentOffset.y);
            scrollView.contentOffset = CGPointMake(0, 0);
        } else {
            if (scrollView.contentOffset.y < 0) {
                self.underView.contentOffset = CGPointMake(0, self.underView.contentOffset.y +scrollView.contentOffset.y);
                scrollView.contentOffset = CGPointMake(0, 0);
            }
        }
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.alpha = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
