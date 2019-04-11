//
//  ThreadObject.m
//  iOSFactory
//
//  Created by kevin on 2019/4/11.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "ThreadObject.h"

@implementation ThreadObject
-(void)run{
    
}


-(NSThread *)creatThreadWithTarget:(id)target selector:(SEL)selector object:(id)argument stackSize:(NSUInteger)size{
    
    /***
     
     主线程栈空间大小为 1M = 1024KB 无法修改（最大值）
     子线程默认栈控件为 512kb （最大值）
     并且，一开始创建线程的时候空间有可能很小，随着使用而增加，
     主线程的栈实际使用空间 <= 1024KB
     子线程的栈实际使用空间 <= 512KB
     
     
     线程启动前，stackd空间大小可以被改变
     size 分配内存的大小单位是1KB,线程创建在栈上，stack的最小值是16kb，而且大小必须是4的倍数  16 20 24 28 32 36 40kb 。。。
     
     时间消耗：（1毫秒 = 1/1000 秒）
     创建：4-5毫秒
     启动：5-100毫秒 平均 29毫秒
     总结：开销较大
     原因：上下文切换带来的开销（CPU在某个时间点只能处理一个线程里的一个事情，如果处理另一个线程，需要上下文切换）
     
     */
    
    if (size % 4096 != 0) {
        return nil;
    }
    
    NSThread *t = [[NSThread alloc] initWithTarget:target selector:selector object:argument];
    t.stackSize = size;
    return t;
    
}
@end
