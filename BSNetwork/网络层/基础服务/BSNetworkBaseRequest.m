//
//  BSNetworkBaseRequest.m
//  Neighbor
//
//  Created by lbs on 2020/3/28.
//  Copyright © 2020 lbs. All rights reserved.
//

#import "BSNetworkBaseRequest.h"

@implementation BSNetworkBaseRequest

- (BSNetworkMethord)methord {
    return BSNetworkMethordGET;
}

- (NSString *)reqURLString {
    return nil;
}

- (NSDictionary *)parameters {
    return @{};
}
@end
