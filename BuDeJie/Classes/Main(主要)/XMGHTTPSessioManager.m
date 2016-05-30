//
//  XMGHTTPSessioManager.m
//  BuDeJie
//
//  Created by 张战威 on 16/4/22.
//  Copyright © 2016年 张战威. All rights reserved.
//

#import "XMGHTTPSessioManager.h"

@implementation XMGHTTPSessioManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        [self.requestSerializer setValue:@"123" forHTTPHeaderField:@"Cookie"];
        [self.requestSerializer setValue:@"iPhone" forHTTPHeaderField:@"Phone"];
        [self.requestSerializer setValue:@"9.2" forHTTPHeaderField:@"OS_VERSION"];
    }
    return self;
}

@end
