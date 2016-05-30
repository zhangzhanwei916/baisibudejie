//
//  XMGSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/16.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "XMGTopic.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface XMGSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) UIImageView *imageView;

/* 自动生成的内容：number的getter\setter声明+实现、_number成员变量*/
//@property (nonatomic, assign) NSInteger number;

/* 自动生成的内容：number的getter声明+实现、_number成员变量*/
//@property (nonatomic, assign, readonly) NSInteger number;

// 在interface中写方法的声明，是为了点语法有智能提示
- (PHFetchResult<PHAsset *> *)createdAssets;
- (PHAssetCollection *)createdCollection;
@end

@implementation XMGSeeBigPictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];

    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.saveButton.enabled = YES;
    }];
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_x = 0;
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 处理图片的高度问题
    imageView.xmg_height = imageView.xmg_width * self.topic.height / self.topic.width;
    if (imageView.xmg_height >= XMGScreenH) { // 长图
        imageView.xmg_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
    } else {
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    
    // 图片缩放问题
    CGFloat maxScale = self.topic.width / imageView.xmg_width;
    if (maxScale > 1.0) { // 增加放大功能
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 点击
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  获得刚才添加到【相机胶卷】中的图片
 */
- (PHFetchResult<PHAsset *> *)createdAssets
{
    __block NSString *createdAssetId = nil;
    
    // 添加图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    
    if (createdAssetId == nil) return nil;
    
    // 在保存完毕后取出图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}

/**
 *  获得【自定义相册】
 */
- (PHAssetCollection *)createdCollection
{
    // 获取软件的名字作为相册的标题
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    // 代码执行到这里，说明还没有自定义相册
    
    __block NSString *createdCollectionId = nil;
    
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    if (createdCollectionId == nil) return nil;
    
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
}

/**
 *  保存图片到相册
 */
- (void)saveImageIntoAlbum
{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    
    if (createdAssets == nil || createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        return;
    }
    
    // 将相片添加到相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 保存结果
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

- (IBAction)save {
    /*
     requestAuthorization方法的功能
     1.如果用户还没有做过选择，这个方法就会弹框让用户做出选择
     1> 用户做出选择以后才会回调block
     
     2.如果用户之前已经做过选择，这个方法就不会再弹框，直接回调block，传递现在的授权状态给block
     */
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: {
                    //  保存图片到相册
                    [self saveImageIntoAlbum];
                    break;
                }
                    
                case PHAuthorizationStatusDenied: {
                    if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                    
                    XMGLog(@"提醒用户打开相册的访问开关")
                    break;
                }
                    
                case PHAuthorizationStatusRestricted: {
                    [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
                    break;
                }
                    
                default:
                    break;
            }
        });
    }];
    
    // PHAuthorizationStatusNotDetermined
    // 用户还没有对当前App授权过(用户从未点击过Don't Allow或者OK按钮)
    
    // PHAuthorizationStatusRestricted
    // 因为一些系统原因导致无法访问相册（比如家长控制）
    
    // PHAuthorizationStatusDenied
    // 用户已经明显拒绝过当前App访问相片数据（用户已经点击过Don't Allow按钮）
    
    // PHAuthorizationStatusAuthorized
    // 用户已经允许过当前App访问相片数据（用户已经点击过OK按钮）
    
//    switch ([PHPhotoLibrary authorizationStatus]) {
//        case PHAuthorizationStatusAuthorized: {
//            [self saveImageIntoAlbum];
//            break;
//        }
//        
//        case PHAuthorizationStatusDenied: {
//            // 提醒用户打开访问开关
//            break;
//        }
//            
//        case PHAuthorizationStatusRestricted: {
//            [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
//            break;
//        }
//            
//        case PHAuthorizationStatusNotDetermined: {
//            // 弹框让用户做出选择
//            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                // 用户刚才点击的是OK按钮
//                if (status == PHAuthorizationStatusAuthorized) {
//                    [self saveImageIntoAlbum];
//                }
//            }];
//            break;
//        }
//    }
}

/*
 PHPhotoLibrary的performChangesAndWait的block不能嵌套，比如下面的写法是错误的
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
 
    } error:nil];
 } error:nil];
 */
@end
