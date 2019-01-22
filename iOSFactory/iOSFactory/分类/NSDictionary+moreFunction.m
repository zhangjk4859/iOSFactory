//
//  NSDictionary+moreFunction.m
//  iOSFactory
//
//  Created by kevin on 2019/1/22.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "NSDictionary+moreFunction.h"

@implementation NSDictionary (moreFunction)
- (void)autoCreatePropetyCode{
    
    // 模型中属性一一对应字典的key
    // 有多少个key,则生成多少个属性
    
    // 创建可变字符串用于拼接属性
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        
        NSString *code = nil;
        
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, cppy) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        
        // 拼接字符串
        [codes appendFormat:@"\n%@\n",code];
        
    }];
    
    // 打印属性
    NSLog(@"%@",codes);
    
}

@end
