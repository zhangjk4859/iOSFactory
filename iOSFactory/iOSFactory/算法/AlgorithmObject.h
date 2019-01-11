//
//  AlgorithmObject.h
//  iOSFactory
//
//  Created by kevin on 2018/11/13.
//  Copyright © 2018 jumu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlgorithmObject : NSObject

/*
 *选择排序
 */
+(NSArray *)selectionSort:(NSArray *)originalArray;

/*
 *插入排序
 */
+(NSArray *)insertionSort:(NSArray <NSString *>*)originalArray;


@end

NS_ASSUME_NONNULL_END
