//
//  Tools.h
//  iOSFactory
//
//  Created by kevin on 2018/12/11.
//  Copyright © 2018 jumu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+moreFunction.h"
#import "UIColor+MoreFunction.h"
#import "UIView+THMoreFunction.h"
NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
/**
 基础计算 截取指定小数位数 时间耗时较少
 */
+ (NSString *)getRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision;

+ (NSDate *)dateMDWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
