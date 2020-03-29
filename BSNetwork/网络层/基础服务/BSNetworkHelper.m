//
//  BSNetworkHelper.m
//  Neighbor
//
//  Created by lbs on 2020/3/25.
//  Copyright © 2020 lbs. All rights reserved.
//

#import "BSNetworkHelper.h"
#import <UIKit/UIKit.h>
#import "BSServerAPI.h"

static NSString *const kBaseUrlKeyType = @"kBaseUrlKeyType";

@implementation BSNetworkHelper

+ (NSString *)serverAPIWithPath:(NSString *)path {
    NSString *baseURLString = kBaseURL_release;
    switch ([self currentNetworkEnrironment]) {
        case BSNetworkEnvironmentRelease:
            baseURLString = kBaseURL_release;
            break;
        case BSNetworkEnvironmentTest:
            baseURLString = kBaseURL_test;
            break;
        case BSNetworkEnvironmentPreRelease:
            baseURLString = kBaseURL_preRlease;
            break;
        case BSNetworkEnvironmentDeveloper:
            baseURLString = kBaseURL_developer;
            break;
    }
    return [NSString stringWithFormat:@"%@%@", baseURLString, path];
}


+ (BSNetworkEnvironment)currentNetworkEnrironment {
    BSNetworkEnvironment type = [[NSUserDefaults standardUserDefaults] integerForKey:kBaseUrlKeyType];
    if (type <= 0) {
        return BSNetworkEnvironmentRelease;
    }
    return type;
}

+ (void)resetNetworkEnvironment:(BSNetworkEnvironment)en {
    [[NSUserDefaults standardUserDefaults] setInteger:en forKey:kBaseUrlKeyType];
}

+ (void)showChangeNetworkEnviroment {
    
    NSString *message = [[NSString alloc] initWithFormat:@"当前环境为%zd，点击按钮可切换网络环境（建议重新打开APP）", [self currentNetworkEnrironment]];
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"切换网络环境" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"1:开发环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetNetworkEnvironment:BSNetworkEnvironmentDeveloper];
    }];
    [alertCtl addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"2:测试环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetNetworkEnvironment:BSNetworkEnvironmentTest];
    }];
    [alertCtl addAction:action2];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"3:预发布环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetNetworkEnvironment:BSNetworkEnvironmentPreRelease];
    }];
    [alertCtl addAction:action3];
    
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"4:生产环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetNetworkEnvironment:BSNetworkEnvironmentRelease];
    }];
    [alertCtl addAction:action4];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtl addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtl animated:YES completion:nil];
}

@end
