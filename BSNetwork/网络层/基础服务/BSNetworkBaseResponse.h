//
//  BSNetworkBaseResponse.h
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * _Nullable const kUnknownCode = @"-10000";
static NSString * _Nullable const kBusinessSucessCode = @"00000";

typedef NS_ENUM(NSInteger, BSNetworkResponseType) {
    BSNetworkResponseTypeSucess, /**< 业务请求成功 */
    BSNetworkResponseTypeBusinessError, /**< 业务请求异常 */
    BSNetworkResponseTypeNetworkError /**< 网络异常 */
};

NS_ASSUME_NONNULL_BEGIN

@interface BSNetworkBaseResponse : NSObject

@property (nonatomic, strong, readonly) id originData; /**< 返回过来的原始数据 */
@property (nonatomic, copy, readonly) NSString *code; /**< 请求结果状态标识。00000: 成功标识符 */
@property (strong, nonatomic, nullable, readonly) NSString *message; /**< 请求结果信息 */
@property (nonatomic, assign, readonly) BSNetworkResponseType type; /**< 网络响应的类型 */


+ (instancetype)responseWith:(nullable id)responseObject error:(nullable NSError *)error;


/// 子类需要重写此方法，来自定义解析数据
/// @param responseDict 服务器返回的字典数据
- (void)parseWith:(NSDictionary *)responseDict;

@end

NS_ASSUME_NONNULL_END
