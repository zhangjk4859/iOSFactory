//
//  AlgorithmObject.m
//  iOSFactory
//
//  Created by kevin on 2018/11/13.
//  Copyright © 2018 jumu. All rights reserved.
//

#import "AlgorithmObject.h"

@implementation AlgorithmObject
+(NSArray *)selectionSort:(NSArray <NSString *>*)originalArray{
    
    NSMutableArray *marray = [NSMutableArray arrayWithArray:originalArray];
    /**
     选择排序思想
     拿第一个数和后面的数依次比较 如果小于自身，进行交换，保证最前面的数总是最小的
     */
    for (int i = 0; i < marray.count - 1; i++) {//i最大为倒数第二位
        NSString *front = marray[i];
        for (int j = i + 1; j < marray.count; j++) {
            NSLog(@"---------i-----------%d",i);
            NSLog(@"-----------j---------%d",j);
            NSString * back = marray[j];
            if ([(NSString *)marray[i] integerValue] > [(NSString *)marray[j] integerValue]) {
                NSLog(@"-----------%@---------",marray[i]);
                NSLog(@"-----------%@---------",marray[j]);
                [marray exchangeObjectAtIndex:i withObjectAtIndex:j];
                NSLog(@"交换了");
            }
        }
    }
    
    return marray;

};
@end
