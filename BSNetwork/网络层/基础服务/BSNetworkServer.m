//
//  BSNetworkServer.m
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import "BSNetworkServer.h"
#import <AFNetworking.h>
#import "BSNetworkBaseRequest.h"
#import "BSNetworkBaseResponse.h"

@interface BSNetworkServer ()

@property (nonatomic, strong) AFHTTPSessionManager *sesionManager;

@end

@implementation BSNetworkServer

+ (instancetype)service {
    
    static BSNetworkServer *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BSNetworkServer alloc] init];
        [service _setup];
    });
    return service;
}

- (void)_setup {

    _sesionManager = [AFHTTPSessionManager manager];
    
    // 构造请求序列化器
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = 10.f;
    
    // 构造响应序列化器
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    _sesionManager.requestSerializer = requestSerializer;
    _sesionManager.responseSerializer = responseSerializer;
    
    // 添加header
    [_sesionManager.requestSerializer setValue:@"sIOS" forHTTPHeaderField:@"clientType"];

}

#pragma mark - 提供给外部使用的接口

- (nullable NSURLSessionDataTask *)request:(BSNetworkBaseRequest *)request
                                  complete:(nullable BSRequestCompleteBlock)complete {
    
    if(request.methord == BSNetworkMethordPOST) {
        return [self _POST:request complete:complete];
    }
    if(request.methord == BSNetworkMethordGET) {
        return [self _GET:request complete:complete];
    }
    return nil;
}

#pragma mark - GET/POST请求
// GET请求
- (nullable NSURLSessionDataTask *)_GET:(BSNetworkBaseRequest *)request
                               complete:(nullable BSRequestCompleteBlock)complete {
    return [self.sesionManager
            GET:request.reqURLString
            parameters:request.parameters
            progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [self _handleSuccesRequest:request responseObject:responseObject complete:complete];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [self _handleFaildRequest:request error:error complete:complete];
       }];
}

// POST请求
- (nullable NSURLSessionDataTask *)_POST:(BSNetworkBaseRequest *)request
                               complete:(nullable BSRequestCompleteBlock)complete {
    return [self.sesionManager
            POST:request.reqURLString
            parameters:request.parameters
            progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [self _handleSuccesRequest:request responseObject:responseObject complete:complete];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [self _handleFaildRequest:request error:error complete:complete];
       }];
}

#pragma mark - 请求成功或者失败的处理
/// 请求失败的处理
- (void)_handleFaildRequest:(BSNetworkBaseRequest *)request
                       error:(nullable NSError *)error
                    complete:(nullable BSRequestCompleteBlock)complete {
    
    [self _printRequest:request responseObject:nil error:error];

    if (complete) {
        complete([self _responseWithRequest:request responseObject:nil]);
    }
}

/// 请求成功的处理
- (void)_handleSuccesRequest:(BSNetworkBaseRequest *)request
              responseObject:(nullable id)responseObject
                    complete:(nullable BSRequestCompleteBlock)complete {
    
  
    [self _printRequest:request responseObject:responseObject error:nil];
    
    
    // 回调
    if(complete) {
        complete([self _responseWithRequest:request responseObject:responseObject]);
    }
}

/// 解析出request对应的response
- (BSNetworkBaseResponse *)_responseWithRequest:(BSNetworkBaseRequest *)request
                                responseObject:(nullable id)responseObject {
    NSString *reqestClassName = NSStringFromClass(request.class);
    NSRange suffixRange = [reqestClassName rangeOfString:@"Request"];
    NSString *responseClassName = [NSString stringWithFormat:@"%@Response", [reqestClassName substringToIndex:suffixRange.location]];
    BSNetworkBaseResponse *response = [NSClassFromString(responseClassName) performSelector:@selector(responseWith:error:) withObject:responseObject withObject:nil];
    if (response == nil) {
        NSString *tipMessage = [NSString stringWithFormat:@"请检查%@有没有创建对应的Response类:%@", reqestClassName, responseClassName];
        NSAssert(NO, tipMessage);
    }
    return response;
}

/// 打印网络请求
- (void)_printRequest:(BSNetworkBaseRequest *)request
       responseObject:(nullable id)responseObject
                error:(nullable NSError *)error {
    // 解析成json字符串，方便打印
      NSError *parseError = nil;
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&parseError];
      NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {
        NSLog(@"\n=======网络错误%@   url:%@   parameter:%@  error msg:%@",(request.methord == BSNetworkMethordPOST? @"POST" : @"GET"),request.reqURLString,request.parameters,error.localizedDescription);
    } else {
        // 打印请求信息
        NSLog(@"\n=======%@%@   parameter:%@ \njson:  %@",(request.methord == BSNetworkMethordPOST? @"POST" : @"GET"),request.reqURLString,request.parameters,jsonString);

    }
}

@end
