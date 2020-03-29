//
//  BSServerAPI.h
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#ifndef BSServerAPI_h
#define BSServerAPI_h


static NSString *const kBaseURL_release = @"https://abc.com";
static NSString *const kBaseURL_developer = @"https://abc.com";
static NSString *const kBaseURL_preRlease = @"https://abc.com";
static NSString *const kBaseURL_test = @"https://abc.com";


// 账户模块
static NSString *const kAPI_pwdLogin = @"/api/v1/user/pwdLogin"; // 密码登陆
static NSString *const kAPI_logout = @"/api/v1/user/logout"; // 退出登陆


#endif /* BSServerAPI_h */
