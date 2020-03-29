//
//  BSNetworkHelper.h
//  Neighbor
//
//  Created by lbs on 2020/3/25.
//  Copyright © 2020 lbs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BSNetworkEnvironment) {
    BSNetworkEnvironmentDeveloper,
    BSNetworkEnvironmentTest,
    BSNetworkEnvironmentPreRelease,
    BSNetworkEnvironmentRelease
};

NS_ASSUME_NONNULL_BEGIN

@interface BSNetworkHelper : NSObject

/// 返回当前网络环境，拼接后的URL字符串
+ (NSString *)serverAPIWithPath:(NSString *)path;

/// 返回当前网络环境
+ (BSNetworkEnvironment)currentNetworkEnrironment;

/// 设置当前网络环境
+ (void)resetNetworkEnvironment:(BSNetworkEnvironment)en;

/// 弹出设置网络环境的框
+ (void)showChangeNetworkEnviroment;

@end

NS_ASSUME_NONNULL_END
