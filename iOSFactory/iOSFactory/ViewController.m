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

#import "YXPopADView.h"
#import <Masonry.h>
#import <MediaPlayer/MediaPlayer.h>
#import "THCommonWordsView.h"
@interface ViewController ()<NSURLSessionDataDelegate>


@end

@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
  
    //角标
    UIView *testView = [[UIView alloc]init];
    testView.frame = CGRectMake(100, 50, 100, 100);
    NSString *str = @"1";
    [testView setBadgeValue:str];
    testView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:testView];

    

}



@end
