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
#import "THURLProtocol.h"

@interface ViewController ()<NSURLSessionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     1.将URL中的域名替换成HTTPDNS解析出来的IP
     
     2.添加包头Host
     
     3.添加自己想要添加的Cookie，这一步视需求而定
     
     */
    


    
    

    
    

}



#pragma mark -- HttpDNSDegradationDelegate
/*
- (BOOL)shouldDegradeHTTPDNS:(NSString *)hostName {
    //根据HTTPDNS使用说明，存在网络代理情况下需降级为Local DNS
    if (self.configureProxies) {
        return YES;
    }
    return NO;
}


- (void)configHTTPDNS {
    self.configureProxies = [NetworkManager configureProxies];
    //注册CustomURLProtocol（NSURLProtocol子类）
    [NSURLProtocol registerClass:[THURLProtocol class]];
    
    // 设置AccoutID，当您开通HTTPDNS服务时，您可以在控制台获取到您对应的Accout ID信息
    HttpDnsService *httpdns = [[HttpDnsService alloc] initWithAccountID:156711];
    httpdns.delegate = self;
    
    //设置预解析域名列表
    NSArray * hosts = [[NSArray alloc] initWithObjects: @"你的域名", nil];//这里写上你要通过HTTPDNS解析的域名
    [httpdns setPreResolveHosts:hosts];
    
    //是否允许HTTPDNS返回TTL过期的域名
    [httpdns setExpiredIPEnabled:YES];
    
    //本地日志log开关,测试环境打开
    [httpdns setLogEnabled:NO];
    
    //使用缓存机制
    [httpdns setCachedIPEnabled:YES];
}

*/



-(void)test{
    
    /*
     NSArray * array = @[@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1",@"1",@"4",@"3",@"6",@"1"];
     
     NSLog(@"选择排序=====  %@",[AlgorithmObject selectionSort:array]);
     
     NSLog(@"插入排序=====  %@",[AlgorithmObject insertionSort:array]);
     */
    
}






/*
-(THCouponModel*)handlPriority:(NSMutableArray*)arr{
    
    //日期分离出来
    NSMutableArray *dateArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        THCouponModel *model = obj;
        NSString *dateString = model.valid_until;//根据课程的ID进行区分
        [dateArr addObject:dateString];
        
    }];
    //使用asset把对象去重
    NSSet *set = [NSSet setWithArray:dateArr];
    NSArray *uniqueDateArray = [set allObjects];
    //yes 升序排列
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *ascUniqueDateArray = [uniqueDateArray sortedArrayUsingDescriptors:@[sd1]];
    NSLog(@"%@",ascUniqueDateArray);
    
    
    
    //分成空数组
    NSMutableArray *titleArray = [NSMutableArray array];
    
    
    [ascUniqueDateArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arr = [NSMutableArray array];
        [titleArray addObject:arr];
    }];
    
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        THCouponModel *model = obj;
        NSString *dateString = model.valid_until;
        
        for (NSString *str in ascUniqueDateArray){
            //日期比较
            
            NSDate *date = [dateformater dateFromString:str];
            NSDate *date2 = [dateformater dateFromString:dateString];
            NSComparisonResult result = [date compare:date2];
            if (result == NSOrderedSame){
                //取出对位的数组
                NSMutableArray *arr = [titleArray objectAtIndex:[ascUniqueDateArray indexOfObject:str]];
                [arr addObject:model];//是的话就添加到数组里面
            }
            
        }
        
    }];
    
    
    //拿出数组第一个元素 就是最快过期的y优惠券
    NSArray *nearestDateArray = titleArray.firstObject;
    
    if (nearestDateArray.count <= 0) {
        return nil;
    }
    
    
    //找出价格最高的
    THCouponModel *modelF = nearestDateArray.firstObject;
    for (NSInteger i = 0; i < nearestDateArray.count; i++) {
        THCouponModel *model = nearestDateArray[i];
        modelF = modelF.amount.integerValue >= model.amount.integerValue ? modelF : model;
    }
    
    return modelF;

}

*/


@end
