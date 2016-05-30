//
//  XMGSubTagViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/5.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XMGSubTagItem.h"
#import "XMGSubTagCell.h"
#import "UIColor+Hex.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMGDIYHeader.h"


static NSString * const ID = @"cell";
@interface XMGSubTagViewController ()
@property (nonatomic, weak) NSURLSessionDataTask *task;
@property (nonatomic ,strong) NSArray *subtags;
@end

@implementation XMGSubTagViewController
// 让分割线全屏 -> 1.自定义分割线 2.利用系统属性(iOS6->iOS7 , iOS7 -> iOS8)不能支持iOS8 3.重写cell的setFrame1.取消系统的分割线 2.设置tableView背景色为分割线颜色
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    // 加载数据
    [self loadData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置tableView背景色
    self.tableView.backgroundColor = XMGColor(215, 215, 215);
    
    self.tableView.mj_header = [XMGDIYHeader headerWithRefreshingBlock:^{
        XMGFunc
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 移除指示器
    [SVProgressHUD dismiss];
    // 取消请求
    [_task cancel];
}

#pragma mark - 加载数据
- (void)loadData
{
    // 查看接口文档 -> 发送请求 -> 解析数据
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    // 提示用户
    [SVProgressHUD showWithStatus:@"正在加载ing......."];
    
    // 3.发送请求
    _task = [mgr GET:XMGRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
            
            // 移除指示器
            [SVProgressHUD dismiss];
            
            // 字典数组转模型数组
            _subtags = [XMGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            
            // 刷新表格
            [self.tableView reloadData];
            
            [responseObject writeToFile:@"/Users/张战威/Desktop/课堂共享/07-OC项目/0405/代码/05-订阅标签/subtag.plist" atomically:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 移除指示器
            [SVProgressHUD dismiss];

        }];
}

#pragma mark - Table view data source
// 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.subtags.count;
}

// 返回每个cell长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
  
    cell.item = self.subtags[indexPath.row];
    
    return cell;
}

// 返回每个cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
