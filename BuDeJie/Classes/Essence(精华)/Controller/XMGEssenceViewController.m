//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/3/31.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"

#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

@interface XMGEssenceViewController () <UIScrollViewDelegate>
/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;
@end

@implementation XMGEssenceViewController
#pragma mark - 初始化
// 处理cell间距
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];

    // 默认显示第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVcs
{
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
    
//    XMGAllViewController *all = [[XMGAllViewController alloc] init];
//    all.type = XMGTopicTypeAll;
//    [self addChildViewController:all];
//    
//    XMGVideoViewController *video = [[XMGVideoViewController alloc] init];
//    video.type = XMGTopicTypeVideo;
//    [self addChildViewController:video];
//    
//    XMGVoiceViewController *voice = [[XMGVoiceViewController alloc] init];
//    voice.type = XMGTopicTypeAll;
//    [self addChildViewController:voice];
//    
//    XMGPictureViewController *picture = [[XMGPictureViewController alloc] init];
//    picture.type = XMGTopicTypePicture;
//    [self addChildViewController:picture];
//    
//    XMGWordViewController *word = [[XMGWordViewController alloc] init];
//    word.type = XMGTopicTypeWord;
//    [self addChildViewController:word];
    
    UIButton *t;
}

/**
 *  scrollView
 */
- (void)setupScrollView
{
    NSInteger count = self.childViewControllers.count;
    
    // 不要去自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    // 点击状态栏时,这个scrollView不需要滚动到顶部
    scrollView.scrollsToTop = NO;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    // 其他设置
    scrollView.contentSize = CGSizeMake(count * scrollView.xmg_width, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, XMGNavBarMaxY, self.view.xmg_width, XMGTitlesViewH);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题按钮
    [self setupTitleButtons];
    
    // 下划线
    [self setupTitleUnderline];
}

/**
 *  下划线
 */
- (void)setupTitleUnderline
{
    // 取出标题按钮
    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderline = [[UIView alloc] init];
    CGFloat titleUnderlineH = 2;
    CGFloat titleUnderlineY = self.titlesView.xmg_height - titleUnderlineH;
    titleUnderline.frame = CGRectMake(0, titleUnderlineY, 0, titleUnderlineH);
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 新点击的按钮 -> 红色
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    // 下划线
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.xmg_width = firstTitleButton.titleLabel.xmg_width + XMGMargin;
    self.titleUnderline.xmg_centerX = firstTitleButton.xmg_centerX;
}

/**
 *  标题按钮
 */
- (void)setupTitleButtons
{
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    
    for (NSInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [self.titlesView addSubview:titleButton];
    }
}

// 设置导航条内容
- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 右边
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 监听点击
/**
 *  监听标题按钮点击
 */
- (void)titleButtonClick:(XMGTitleButton *)titleButton
{
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTitleButtonDidRepeatClickNotification object:nil];
    }

    // 修改按钮的状态
    // 上一个点击的按钮 -> 暗灰色
    self.previousClickedTitleButton.selected = NO;
    // 新点击的按钮 -> 红色
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 下划线
        self.titleUnderline.xmg_width = titleButton.titleLabel.xmg_width + XMGMargin;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
        // 滑动scrollView到对应的子控制器界面
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.xmg_width;
        self.scrollView.contentOffset = offset;
    } completion:^(BOOL finished) {
        // 添加index位置的子控制器view到scrollView中
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 控制scrollView的scrollsToTop属性
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        
        // 如果控制器的view没有被创建,跳过
        if (!childVc.isViewLoaded) continue;
        
        // 如果控制器的view不是scrollView,就跳过
        if (![childVc.view isKindOfClass:[UIScrollView class]]) continue;
        
        // 如果控制器的view是scrollView
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        scrollView.scrollsToTop = (i == index);
    }
}

- (void)game
{
    XMGFunc
}

#pragma mark - 其他
/**
 *  添加index位置的子控制器view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    // 取出index位置对应的子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if (childVc.isViewLoaded) return;

    // 设置frame
    childVc.view.frame = CGRectMake(index * self.scrollView.xmg_width, 0, self.scrollView.xmg_width, self.scrollView.xmg_height);
    // 添加
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  scrollView滑动完毕的时候调用(速度减为0的时候调用)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    
    // 如果上一次点击的按钮 和 这次想要点击的按钮 相同，直接返回
    if (self.previousClickedTitleButton == titleButton) return;
    
    [self titleButtonClick:titleButton];
    
//    [self titleButtonClick2:titleButton];
}

@end