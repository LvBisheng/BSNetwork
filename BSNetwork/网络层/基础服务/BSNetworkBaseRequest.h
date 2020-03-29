//
//  BSNetworkBaseRequest.h
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BSNetworkMethord) {
    BSNetworkMethordGET,
    BSNetworkMethordPOST
};

NS_ASSUME_NONNULL_BEGIN

@interface BSNetworkBaseRequest : NSObject

- (NSString *)reqURLString;

- (BSNetworkMethord)methord;

- (NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
