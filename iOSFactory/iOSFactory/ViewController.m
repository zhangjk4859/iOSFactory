//
//  ViewController.m
//  iOSFactory
//
//  Created by kevin on 2018/11/13.
//  Copyright © 2018 jumu. All rights reserved.
//

#import "ViewController.h"
#import "AlgorithmObject.h"
#import "Tools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    /*
    NSArray *originalArray = @[@"5",@"5",@"3",@"4",@"90",@"21",@"1",@"55",@"12",@"32",@"88"];
    NSLog(@"%@",[AlgorithmObject selectionSort:originalArray]);
     */
    
//    NSString *string =  [self getRoundFloat:0.12355 withPrecisionNum:200];
//    NSLog(@"%@",string);
    
    while (1) {
        [self g1etRoundFloat:0.12355 withPrecisionNum:200];
    }
    
    /*
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 10000; ++i) {
            [NSThread sleepForTimeInterval:0.1];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);
            NSLog(@"1---%@",[Tools dateMDWithString:@"123"]);// 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 10000; ++i) {
            [NSThread sleepForTimeInterval:0.1];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
            NSLog(@"2---%@",[Tools dateMDWithString:@"123"]);
        }
    });
     */

}

- (NSString *)getRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision {
    
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    double fact = pow(10,precision);
    double result = round(fact * floatNumber) / fact;
    NSString *proString = [NSString stringWithFormat:@"%%.%ldf",(long)precision];
    NSString *resultString = [NSString stringWithFormat:proString,result];
    
    
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


-(NSString *)g1etRoundFloat:(double)floatNumber withPrecisionNum:(NSInteger)precision{
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    
    NSNumber *tempNumber = [NSNumber numberWithDouble:floatNumber];
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:tempNumber.stringValue];
    //根据位数 四舍五入
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                       scale:precision
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    NSString *positiveStr;
    if (precision == 0) {
        positiveStr = @"0";
    } else {
        positiveStr = @"0.";
        for (NSInteger num = 0; num < precision; num++) {
            positiveStr = [positiveStr stringByAppendingString:@"0"];
        }
    }
    [numberFormatter setPositiveFormat:positiveStr];
    
    NSString *str = [numberFormatter stringFromNumber:[numResult decimalNumberByRoundingAccordingToBehavior:roundUp]];
    
    
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    /** 0.000421 / 0.000020   21倍  CPU 占用降低（没有创建对象）
     
     2018-12-11 10:15:49.946078+0800 iOSFactory[47073:492803] time cost: 0.000298
     2018-12-11 10:15:49.946461+0800 iOSFactory[47073:492803] time cost: 0.000291
     2018-12-11 10:15:49.946834+0800 iOSFactory[47073:492803] time cost: 0.000288
     2018-12-11 10:15:49.947214+0800 iOSFactory[47073:492803] time cost: 0.000297
     2018-12-11 10:15:49.947603+0800 iOSFactory[47073:492803] time cost: 0.000305
     2018-12-11 10:15:49.947981+0800 iOSFactory[47073:492803] time cost: 0.000289
     2018-12-11 10:15:49.948366+0800 iOSFactory[47073:492803] time cost: 0.000294
     2018-12-11 10:15:49.948881+0800 iOSFactory[47073:492803] time cost: 0.000421
     
     */
    NSLog(@"time cost: %0.6f", end - start);
    
    
    return str;
    
    
}






@end
