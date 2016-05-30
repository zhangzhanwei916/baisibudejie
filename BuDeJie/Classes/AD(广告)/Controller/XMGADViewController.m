//
//  XMGADViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/1.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "XMGTabBarController.h"
/*
    占位视图实现:当一个界面,层次结构已经清晰,但是中间某一层位置,或者尺寸不确定,可以采用占位视图
 */

// 加载广告界面 -> 服务器发送 -> AFN -> cocoapods
// 命令行 touch:创建 open:打开 cd:进入到某个文件夹
// --no-repo-update:不要更新仓库,迅速加载第三方框架
// 1.cocoapods 创建podfile文件 , 描述需要导入的第三方框架
// 2.获取框架描述 pod search 第三方框架
// 3.加载第三方框架 pod install/ pod update
// 4.以后只要使用了cocopods,都是通过BuDeJie.xcworkspace

/*
    查看接口文档: 1.基本URL 2.请求方式 3.请求参数
 */

// http://json.cn/ json在线解析器

/*
    http://mobads.baidu.com/cpro/ui/mads.php ?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

#define XMGCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface XMGADViewController ()
// 展示广告图片控件
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (weak, nonatomic) IBOutlet UIImageView *lauchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (nonatomic ,strong) XMGADItem *item;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation XMGADViewController

/*
 业务逻辑:
 1.点击广告图片 跳转到广告界面 用safari打开
 2.广告界面倒计时
 3.点击跳过,直接进入到主框架界面
 */

#pragma mark -点击跳转按钮
//XMGPerson *p_;

- (IBAction)clickJump:(id)sender {
    // 跳转到主框架界面:push,modal,更改窗口的根控制器
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc] init];
//    tabBarVc.delegate = p_ = [[XMGPerson alloc] init];
//    tabBarVc.delegate = (id<UITabBarControllerDelegate>)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    // 销毁定时器
    [_timer invalidate];
}

//- (void)dealloc
//{
//    XMGFunc
//}
#pragma mark - 点击广告图片
- (void)tap
{
    // 跳转到广告界面
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:_item.ori_curl]]) {
        
        [app openURL:[NSURL URLWithString:_item.ori_curl]];
    }
    
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.adView addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
    }
    
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置启动图片 -> 根据不同屏幕 加载不同图片 (屏幕适配)
    [self setupLaunchImage];
    
    // 加载广告数据
    [self loadData];
    
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

// 每隔1秒就会调用
- (void)timeChange
{
    static int i = 3;
    
    if (i <= 0) { // 计时完成
        [self clickJump:nil];
    }
    
    i--;
    
    // 设置按钮标题
    NSString *str = [NSString stringWithFormat:@"跳过 (%d)",i];
    [self.jumpBtn setTitle:str forState:UIControlStateNormal];
    
}

// 加载广告数据
- (void)loadData
{
    // 请求数据 -> 查看接口文档 -> 测试接口有没有问题 -> 解析数据(w_picurl,ori_curl:广告界面跳转地址,w,h) arr = dict[@"ad"]
    
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.创建请求参数:字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = XMGCode2;
    
    // 3.发送请求(get,post)
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
         // 解析数据 -> 写成plist文件 -> 字典转模型 -> 模型数据展示界面
        // 获取广告字典数据
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        // 字典转模型
        _item = [XMGADItem mj_objectWithKeyValues:adDict];
        
        // 防止除以0
        if (_item.w <= 0) return;
        
        // 展示界面
        CGFloat w = XMGScreenW;
        CGFloat h = XMGScreenW / _item.w * _item.h;
        self.imageView.frame = CGRectMake(0, 0, w, h);
        // 加载广告图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
        // 写成plist文件
        [responseObject writeToFile:@"/Users/张战威/Desktop/课堂共享/07-OC项目/0405/代码/04-广告/ad.plist" atomically:YES];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 请求失败
        NSLog(@"%@",error);
        
    }];
    
}

// 加载启动图片
- (void)setupLaunchImage
{
    // 6P: 736
    // 6:   667
    // 5 : 568
    // 4 : 480
    // 根据不同屏幕高度 加载不同图片
    UIImage *image = nil;
    
    if (iphone6P) { // 6P
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iphone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    _lauchImageView.image = image;
}

@end
