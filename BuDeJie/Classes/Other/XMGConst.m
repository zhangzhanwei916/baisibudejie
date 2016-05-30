#import <UIKit/UIKit.h>

/** 统一的通用间距 */
CGFloat const XMGMargin = 10;

/** 导航栏的最大Y值(底部) */
CGFloat const XMGNavBarMaxY = 64;

/** TabBar的高度 */
CGFloat const XMGTabBarH = 49;

/** 标题栏的高度 */
CGFloat const XMGTitlesViewH = 35;

/** 请求路径 */
NSString * const XMGRequestURL = @"http://api.budejie.com/api/api_open.php";

/** TabBarButton被重复点击的通知 */
NSString * const XMGTabBarButtonDidRepeatClickNotification = @"XMGTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString * const XMGTitleButtonDidRepeatClickNotification = @"XMGTitleButtonDidRepeatClickNotification";