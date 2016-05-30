//
//  XMGMeViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XMGSquareItem.h"
#import "XMGSquareCell.h"
#import <SafariServices/SafariServices.h>
#import "XMGWebViewController.h"

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - ((cols - 1) * margin)) / cols

@interface XMGMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNavBar];
    
    // 设置footView
    [self setupFootView];
    
    // 加载数据
    [self loadData];
  
    // 设置tableView组间距
    // 如果是分组样式,默认每一组都会有头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XMGMargin;
    
    // 设置顶部额外滚动区域-25
    self.tableView.contentInset = UIEdgeInsetsMake(XMGMargin - 35, 0, 0, 0);
    
    [self setupNote];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
}

/**
 *  tabBarButton被重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    
    XMGFunc
}

#pragma mark - 设置界面
// 设置底部视图
- (void)setupFootView
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.scrollsToTop = NO;
    collectionView.backgroundColor = XMGGlobeColor;
    
    self.tableView.tableFooterView = collectionView;
    
    // 设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"XMGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}


// 设置导航条内容
- (void)setupNavBar
{
    // 右边
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // 中间 titleView
    self.navigationItem.title = @"我的";
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
}

// 点击设置按钮就会调用
- (void)setting
{
    XMGSettingViewController *settingVc = [[XMGSettingViewController alloc] init];
    
    // 一定要注意:在Push之前去设置这个属性
    settingVc.hidesBottomBarWhenPushed = YES;
    
    // 跳转到设置界面
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark -加载数据
- (void)loadData
{
    // 发送请求 -> 查看接口文档 -> AFN
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:XMGRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        // 字典数组
        NSArray *dictArr = responseObject[@"square_list"];
        
        // 字典数组转换层模型数组
        _squareItems = [XMGSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 处理数据
        [self resolveData];
        
        // 刷新表格
        [self.collectionView reloadData];
        
        // 4 5 9
        // 设置collectionView高度 => 跟行数 => 总个数 行数:(count - 1) / cols + 1
        NSInteger count = _squareItems.count;
        
        NSInteger rows = (count - 1) / cols + 1;
        
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        
        self.collectionView.xmg_height = collectionH;
        
        // 设置tableView滚动范围 => tableView滚动范围是系统会自动根据内容去计算
        self.tableView.tableFooterView = self.collectionView;
        
        // 重新计算contentSize
        [self.tableView reloadData];
        
        [responseObject writeToFile:@"/Users/张战威/Desktop/课堂共享/07-OC项目/0406/代码/07-我的界面/square.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 处理数据
- (void)resolveData
{
    // 判断缺几个
    // 3 % 4 = 3 4 - 1 0
    NSInteger count = self.squareItems.count;
    
    NSInteger extre = count % cols;
    if (extre) { // 补模型
        extre = cols - extre;
        
        for (int i = 0; i < extre; i++) {
            
            XMGSquareItem *item = [[XMGSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 点击cell就会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取模型
    XMGSquareItem *item = self.squareItems[indexPath.row];
    
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    // WKWebView:UIWebView升级版,监听进度条,数据缓存,iOS8才有
    XMGWebViewController *webVc = [[XMGWebViewController alloc] init];
    webVc.url = url;
    [self.navigationController pushViewController:webVc animated:YES];
}


@end
