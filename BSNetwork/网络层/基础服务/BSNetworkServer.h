//
//  BSNetworkServer.h
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSNetworkBaseRequest;
@class BSNetworkBaseResponse;

// 请求完成的回调
typedef void (^BSRequestCompleteBlock)(BSNetworkBaseResponse * _Nonnull response);


NS_ASSUME_NONNULL_BEGIN

@interface BSNetworkServer : NSObject


/// 返回单例
+ (instancetype)service;


/// 发起一个网络请求。1.需要创建BSNetworkBaseRequest子类，如BSLoginRequest 2.创建request对应的继承BSNetworkBaseResponse的子类，如BSLoginResponse
/// @param request 请求类，需要继承自BSNetworkBaseRequest，并重写父类方法。
/// @param complete 网络请求成功或者失败的回调
- (nullable NSURLSessionDataTask *)request:(BSNetworkBaseRequest *)request
                                  complete:(nullable BSRequestCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END

