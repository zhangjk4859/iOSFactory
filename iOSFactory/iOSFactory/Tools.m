//
//  Tools.m
//  iOSFactory
//
//  Created by kevin on 2018/12/11.
//  Copyright © 2018 jumu. All rights reserved.
//

#import "Tools.h"


@implementation Tools

/**
 基础计算 截取指定小数位数 时间耗时较少
 */
+ (NSString *)getRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision {
    
    // 0.123456789
    
    //core foundation 的当前确切时间
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    //精度要求为2，算出 10的2次方，也就是100，让小数点右移两位，让原始小数扩大100倍
    double fact = pow(10,precision);
    //让小数扩大100倍，四舍五入后面的位数，再缩小100倍，这样成功的进行指定精度的四舍五入
    double result = round(fact * floatNumber) / fact;
    //组合成字符串 @"%.3f"   想要打印百分号%字符串 需要在前面加一个百分号 表示不转译
    NSString *proString = [NSString stringWithFormat:@"%%.%ldf",(long)precision];
    // 默认会显示6位 多余的n补0，所以需要指定显示多少小数位  @"%.3f" 0.123000
    NSString *resultString = [NSString stringWithFormat:proString,result];
    
    //time实际上是一个double
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    /**
     
     2018-12-11 10:12:16.626811+0800 iOSFactory[47030:491007] time cost: 0.000013
     2018-12-11 10:12:16.627027+0800 iOSFactory[47030:491007] time cost: 0.000013
     2018-12-11 10:12:16.627183+0800 iOSFactory[47030:491007] time cost: 0.000012
     2018-12-11 10:12:16.627361+0800 iOSFactory[47030:491007] time cost: 0.000012
     2018-12-11 10:12:16.627577+0800 iOSFactory[47030:491007] time cost: 0.000013
     2018-12-11 10:12:16.627807+0800 iOSFactory[47030:491007] time cost: 0.000020
     2018-12-11 10:12:16.628027+0800 iOSFactory[47030:491007] time cost: 0.000013
     
     */
    NSLog(@"time cost: %0.6f", end - start);
    
    return resultString;
    
}



static NSDateFormatter *dateFormatter = nil;
+ (NSDate *)dateMDWithString:(NSString *)str{
    
    
//    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
//    [dateFormatter setTimeZone:localTimeZone];
//
//    NSDate *date = [dateFormatter dateFromString:str];
//    NSLog(@"%p",dateFormatter);
//
//
//    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
//    NSLog(@"time cost: %0.6f", end - start);// time cost: 0.000442
//
//    return date;
    
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    /**
     线程安全
     */

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
            [dateFormatter setTimeZone:localTimeZone];
        }

    });


    NSDate *date = [dateFormatter dateFromString:str];
    NSLog(@"%p",dateFormatter);
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    /**
     运行速度提升2倍  CPU占用率降低
     */
    NSLog(@"time cost: %0.6f", end - start);// 0.000177  0.000394 0.000210
    return date;
}

@end
