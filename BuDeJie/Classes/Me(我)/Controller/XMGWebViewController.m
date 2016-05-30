//
//  XMGWebViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/6.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGWebViewController.h"
#import <WebKit/WebKit.h>
@interface XMGWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation XMGWebViewController
/*
    使用步骤
    1.导入 WebKit框架
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 添加WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView = webView;
    [self.view insertSubview:webView atIndex:0];

    // 加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    // KVO: 让self对象监听webView的estimatedProgress
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听的属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    _progressView.progress = _webView.estimatedProgress;
    
    _progressView.hidden = _progressView.progress >= 1;
}

// KVO一定要移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
