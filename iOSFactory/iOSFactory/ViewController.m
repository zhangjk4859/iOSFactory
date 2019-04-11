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
#import "ThreadObject.h"
@interface ViewController ()<NSURLSessionDataDelegate>


@end

@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
  
    ThreadObject *obj = [ThreadObject new];
    [obj run];
    
}




@end
