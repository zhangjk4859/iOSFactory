//
//  UIColor+MoreFunction.h
//  iOSFactory
//
//  Created by kevin on 2019/2/19.
//  Copyright © 2019 jumu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MoreFunction)
+ (UIColor *)colorWithHex:(NSString *)string;
+ (UIColor *)colorWithHex:(NSString *)string alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
