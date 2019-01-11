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
    
    NSInteger count = 0;
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    NSMutableArray *marray = [NSMutableArray arrayWithArray:originalArray];
    /**
     选择排序思想
     拿第一个数 和 后面所有的数对比，谁小就在第一位
     */

    /**
     --- (3) (4)  1   2   3;  3 < 4;  结果  3 4 1 2 3
     
     --- (3)  4  (1)  2   3;  3 > 1;  结果  1 4 3 2 3
     
     --- (1)  4   3  (2)  3   1 < 2;  结果  1  4   3  2  3
     
     --- (1)  4   3  2  (3)   1 < 3;  结果  1  4   3  2  3
     
     循环结束，第一位是最小的，比后面的都小，虽然后面的排序不对

     */
    
    // 5, 0 1 2 3 4; 倒数第二位是3
    for (int i = 0; i < marray.count - 1; i++) {//i最大位数倒数第二位
        for (int j = i + 1; j < marray.count; j++) {
            count ++;
            NSInteger frontNumber = [(NSString *)marray[i] integerValue];
            NSInteger backNumber = [(NSString *)marray[j] integerValue];
            if (frontNumber > backNumber) {
                [marray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"选择排序循环-----%ld次",count);
    
    NSLog(@"选择排序耗时-----%.6f", end - begin);
    
    return marray;

};


/**
 新建一个可变数组，挨个从原数组中拿出数字，跟第一个比，如果小，就放在第一位，如果大，从第二个数字开始比，小于等于 就插到前面，大于就跟下一个比，依次类推，比到最后一个数字时，如果大于最后一个，添加到数组最后一个
 经过测试，效率是选择排序的2.2倍
 
 */
+(NSArray *)insertionSort:(NSArray <NSString *>*)originalArray{
    
    NSInteger count = 0;
    
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    NSMutableArray *marray = [NSMutableArray array];
    
    for (int i = 0; i < originalArray.count; i++) {
         NSString *number = (NSString *)originalArray[i];
        if (i == 0) {
            [marray addObject:number];
            count ++;
            continue;
        }
        
         NSString *minNumber = marray[0];
        if ([number integerValue] <= [minNumber integerValue]) {
            [marray insertObject:number atIndex:0];
            count ++;
            continue;
        }else{//大于首位
            
           
            //插入到第一位后面
            if (marray.count == 1) {
                [marray addObject:number];
                count ++;
                continue;
            }
            
            NSInteger j = 1;
            
            do {
                NSString *backNumber = marray[j];
                
                if ([number integerValue] <= [backNumber integerValue]) {
                    [marray insertObject:number atIndex:j];
                    j = marray.count;//结束循环
                    count ++;
                    continue;
                }
                
                //当前数字 比最后一位数字 还大的时候 添加进去
                if (j == marray.count - 1) {
                    [marray addObject:number];
                    j = marray.count;//结束循环
                    count ++;
                    continue;
                }
                
                j++;
                count ++;
            } while (j < marray.count);

        }

    }

    
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSLog(@"插入排序循环-----%ld次",count);
    
    NSLog(@"插入排序耗时-----%.6f", end - begin);
    
    return marray;
};


@end
