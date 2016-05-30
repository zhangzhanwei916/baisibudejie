//
//  XMGTopicViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/9.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGTopicViewController.h"
#import "XMGHTTPSessioManager.h"
#import <MJExtension.h>
#import "XMGTopic.h"
#import "XMGTopicCell.h"
#import <SVProgressHUD.h>
#import "XMGRefreshHeader.h"
#import "XMGDIYHeader.h"
#import "XMGRefreshFooter.h"

@interface XMGTopicViewController ()
/** 所有的帖子数据(里面都是XMGTopic模型)*/
@property (nonatomic, strong) NSMutableArray<XMGTopic *> *topics;
/** 用来加载下一页数据的参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 发送请求的管理者 */
@property (nonatomic, strong) XMGHTTPSessioManager *manager;
@end

@implementation XMGTopicViewController

static NSString * const XMGTopicCellId = @"XMGTopicCellId";

/** 在这里重写这个方法的目的：消除警告 */
- (XMGTopicType)type {return 0;}

- (XMGHTTPSessioManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessioManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = XMGGlobeColor;
    self.tableView.contentInset = UIEdgeInsetsMake(XMGNavBarMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    
    // 监听通知
    [self setupNote];
    
    // 添加刷新控件
    [self setupRefresh];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
}

/**
 *  tabBarButton被重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    //    if (当前控制器的界面不在屏幕正中间) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    //    if (当前控制器的界面不在窗口上) return;
    if (self.tableView.window == nil) return;
    
    // 进入下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  titleButton被重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh
{
    // 广告
    UILabel *ad = [[UILabel alloc] init];
    ad.textAlignment = NSTextAlignmentCenter;
    ad.textColor = [UIColor whiteColor];
    ad.text = @"广告广告广告广告广告";
    ad.backgroundColor = [UIColor grayColor];
    ad.xmg_height = 35;
    self.tableView.tableHeaderView = ad;
    
    // 下拉加载新数据的控件
    self.tableView.mj_header = [XMGDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
//    [self.tableView mj_addNormalHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    [self.tableView mj_addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    [self.tableView mj_addAbcHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    [self.tableView mj_addFFFHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    [self.tableView mj_addGGGHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 上拉加载更多数据的控件
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据
/**
 *  加载最新的帖子数据(首页数据, 第1页)
 */
- (void)loadNewTopics
{
    // 取消请求
    // 仅仅是取消请求, 不会关闭session
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    // 发送请求
    [self.manager GET:XMGRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(恢复刷新控件的状态)
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新(恢复刷新控件的状态)
        [self.tableView.mj_header endRefreshing];
        
        // 如果是因为取消任务来到failure这个block, 就直接返回, 不需要提醒错误信息
        if (error.code == NSURLErrorCancelled) return;
        
        // 请求失败的提醒
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
}

/**
 *  加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    // 取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [self.manager GET:XMGRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSMutableArray *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(恢复刷新控件的状态)
        [self.tableView.mj_footer endRefreshing];
//        if (self.topics.count >= maxCount) {
////            self.tableView.mj_footer.hidden = YES;
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            [self.tableView.mj_footer endRefreshing];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新(恢复刷新控件的状态)
        [self.tableView.mj_footer endRefreshing];
        
        // 如果是因为取消任务来到failure这个block, 就直接返回, 不需要提醒错误信息
        if (error.code == NSURLErrorCancelled) return;
        
        // 请求失败的提醒
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    // 传递模型数据
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}
@end
