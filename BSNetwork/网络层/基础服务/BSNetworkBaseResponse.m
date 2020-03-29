//
//  BSNetworkBaseResponse.m
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import "BSNetworkBaseResponse.h"

@interface BSNetworkBaseResponse ()

@property (nonatomic, strong) id originData; /**< 返回过来的原始数据 */
@property (nonatomic, copy) NSString *code; /**< 请求结果状态标识。00000: 成功标识符 */
@property (strong, nonatomic, nullable) NSString *message; /**< 请求结果信息 */
@property (nonatomic, assign,) BSNetworkResponseType type; /**< 网络响应的类型 */


@end
@implementation BSNetworkBaseResponse

+ (instancetype)responseWith:(nullable id)responseObject error:(nullable NSError *)error {
    BSNetworkBaseResponse *rsp = [BSNetworkBaseResponse new];
    
    if (error) {
        // 网络出现了错误
        rsp.code = [NSString stringWithFormat:@"%zd", error.code];
        rsp.message = error.localizedDescription;
        rsp.type = BSNetworkResponseTypeNetworkError;
    } else {
        // 网络正常
        
        rsp.originData = responseObject;
        // 1.解析成字典
        NSDictionary *responseDict = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            responseDict = responseObject;
        }
        if ([responseObject isKindOfClass:[NSData class]]){
            NSData *tempData = (NSData *)responseObject;
            responseDict = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:nil];
        }

        
        // 2.code解析
        id codeValue = [responseDict valueForKey:@"code"];
        if ([codeValue isKindOfClass:[NSString class]]) {
            rsp.code = (NSString *)codeValue;
        } else {
            rsp.code = kUnknownCode;
            NSAssert(NO, @"服务器返回数据有误：code的value应该为String");
        }
        
        // 2.message解析
        id messageValue = [responseDict valueForKey:@"message"];
        if([messageValue isKindOfClass:[NSString class]]) {
            rsp.message = (NSString *)messageValue;
        } else {
            rsp.message = @"未知错误";
        }
        
        // 区分类型
        if (rsp.code == kBusinessSucessCode) {
            rsp.type = BSNetworkResponseTypeSucess;
        } else {
            rsp.type = BSNetworkResponseTypeBusinessError;
        }
    }
        
    return rsp;
}

- (void)parseWith:(NSDictionary *)responseDict {
    
}

@end
