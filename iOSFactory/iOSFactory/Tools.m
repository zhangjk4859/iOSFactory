//
//  Tools.m
//  iOSFactory
//
//  Created by kevin on 2018/12/11.
//  Copyright © 2018 jumu. All rights reserved.
//

#import "Tools.h"


@implementation Tools

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
