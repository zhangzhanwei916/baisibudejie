//
//  XMGSettingViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/1.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGSettingViewController.h"
#import <SDImageCache.h>
#import "XMGFileManager.h"
#define cachePath  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
static NSString * const ID = @"cell";
@interface XMGSettingViewController ()
@end

@implementation XMGSettingViewController

- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

// 整个应用程序下所有的返回按钮 都 一样 -> 如何统一设置返回按钮(每次push都需要设置返回按钮)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 通过这个方式去设置导航标题
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStyleDone target:self action:@selector(jump)];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 从缓存池取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self getFileSizeStr];
    
    return cell;
}

// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 获取Cache文件下所有文件
    // 获取文件夹下一级目录
    [XMGFileManager removeDirectoryPath:cachePath];
    
    // 刷新表格
    [self.tableView reloadData];
}

// 获取文件尺寸字符串
- (NSString *)getFileSizeStr
{
    // 获取Cache文件夹路径
    // b -> b / 1000 KB -> KB / 1000 MB
    // 获取文件夹尺寸
    NSInteger totalSize = [XMGFileManager getDirectorySize:cachePath];
    
    NSString *str = @"清除缓存";
    if (totalSize > 1000 * 1000) { // MB
        CGFloat totalSizeF = totalSize / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)",str,totalSizeF];
    } else if (totalSize > 1000) { // KB
        CGFloat totalSizeF = totalSize / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)",str,totalSizeF];
    } else if (totalSize > 0) { // B
        str = [NSString stringWithFormat:@"%@(%ldB)",str,totalSize];
    }

    return str;
}
// 业务类:专门搞一个类 处理某些业务 网络处理工具类,数据缓存,文件尺寸

@end
