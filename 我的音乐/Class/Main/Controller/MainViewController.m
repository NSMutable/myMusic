//
//  MainViewController.m
//  我的音乐
//
//  Created by 陈淼 on 16/6/6.
//  Copyright © 2016年 陈淼. All rights reserved.
//  /****************
//  navigationBar和tabBar的搭建
//  ****************/

#import "MainViewController.h"
#import "HomeView.h"


@interface MainViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *underView;

@property (nonatomic, strong) UIButton *myMusicBtn;

@property (nonatomic, strong) UIButton *musicLibraryBtn;

@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UISearchBar *searchBar;
//搜索栏有关的列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self configNaviBar];
    [self configTabBar];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.underView) {
        
        if (scrollView.contentOffset.x == kScreenWidth)
        {
            self.myMusicBtn.selected = NO;
            self.musicLibraryBtn.selected = YES;
        }else if (scrollView.contentOffset.x == 0) {
            self.myMusicBtn.selected = YES;
            self.musicLibraryBtn.selected = NO;
        }
    }
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == [self.view viewWithTag:123456]) {
        
        int offsetX = targetContentOffset->x;
        offsetX = offsetX % (int)kScreenWidth;
        targetContentOffset->x -= offsetX;
    }
    
}


- (void)configNaviBar {
    
    
    
    UIButton *rightBtn = [UIButton buttonWithType:0];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(showSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:IMAGE(@"cm2_list_icn_search@2x") forState:0];
    
    self.myMusicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myMusicBtn.frame = CGRectMake(kScreenWidth / 2 - kWidth(20) - kWidth(50), 10, kWidth(50), 25);
    [self.navigationController.navigationBar addSubview:self.myMusicBtn];
    [self.myMusicBtn setTitleColor:UIColorFromRGB(0xfa7e33) forState:UIControlStateSelected];
    [self.myMusicBtn setTitleColor:UIColorFromRGB(0x5d5558) forState:UIControlStateNormal];
    [self.myMusicBtn setTitle:@"我的" forState:UIControlStateNormal];
    [self.myMusicBtn addTarget:self action:@selector(myMusicAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.musicLibraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.musicLibraryBtn.frame = CGRectMake((kScreenWidth / 2) + kWidth(20), 10, kWidth(50), 25);
    [self.navigationController.navigationBar addSubview:self.musicLibraryBtn];
    [self.musicLibraryBtn setTitleColor:UIColorFromRGB(0xfa7e33) forState:UIControlStateSelected];
    [self.musicLibraryBtn setTitleColor:UIColorFromRGB(0x5d5558) forState:UIControlStateNormal];
    [self.musicLibraryBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [self.musicLibraryBtn addTarget:self action:@selector(musicLibraryAction:) forControlEvents:UIControlEventTouchUpInside];
    self.musicLibraryBtn.selected = YES;
    
    
#pragma - mark 一开始藏在上面的搜索栏
    self.searchView = [[UIView alloc] init];
    self.searchView.frame = CGRectMake(0, -84, kScreenWidth, 64);
    [self.navigationController.navigationBar addSubview:self.searchView];
    self.searchView.backgroundColor = kWhiteColor;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(18, 28, kScreenWidth - 18 - 68, 30)];
    [self.searchView addSubview:self.searchBar];
    self.searchBar.barStyle = UIBarStyleBlack;
    self.searchBar.layer.cornerRadius = 5;
    
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    cancelBtn.frame = CGRectMake(kScreenWidth - 17 - 34, 35, 68 - 34, 16);
    [cancelBtn setTitle:@"取消" forState:0];
    [self.searchView addSubview:cancelBtn];
    cancelBtn.titleLabel.font = k15Font;
    [cancelBtn addTarget:self action:@selector(hidSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:kBlackColor forState:0];
    
    self.underView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.underView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.underView];
    
    //创建互动视图的内容视图
    UIView *myMusicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    myMusicView.backgroundColor = [UIColor redColor];
    [self.underView addSubview:myMusicView];
    
    
    HomeView *homeView = [[HomeView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    [self.underView addSubview:homeView];
    
    self.underView.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    self.underView.showsHorizontalScrollIndicator = YES;
    self.underView.bounces = NO;
    self.underView.scrollEnabled = YES;
    self.underView.delegate = self;
    self.underView.pagingEnabled = YES;
    self.underView.contentOffset = CGPointMake(kScreenWidth, 0);
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)showSearchBar {
    [self.searchBar becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.searchView.transform = CGAffineTransformMakeTranslation(0, 64);
    }];
    self.tableView.hidden = NO;
}

- (void)hidSearchBar {
    [self.searchBar resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.searchView.transform = CGAffineTransformIdentity;
    }];
    self.tableView.hidden = YES;
}

- (void)myMusicAction:(UIButton *)button {
    self.underView.contentOffset = CGPointMake(0, 0);
    self.myMusicBtn.selected = YES;
    self.musicLibraryBtn.selected = NO;
}

- (void)musicLibraryAction:(UIButton *)button {
    self.underView.contentOffset = CGPointMake(kScreenWidth, 0);
    self.myMusicBtn.selected = NO;
    self.musicLibraryBtn.selected = YES;
}

- (void)configTabBar {
    
    for (UIView *view in self.tabBarController.tabBar.subviews ) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.musicLibraryBtn.hidden = NO;
    self.myMusicBtn.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.musicLibraryBtn.hidden = YES;
    self.myMusicBtn.hidden = YES;
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



