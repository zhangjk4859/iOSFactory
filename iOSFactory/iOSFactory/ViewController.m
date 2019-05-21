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
#import "TableViewCell.h"


@interface ViewController ()<NSURLSessionDataDelegate>


@end


void caculateGoldenRatio(){
    static double number = 2;
    number = 1 / number + 1;
    printf("%lf\n",number);
//    caculateGoldenRatio();
}



void swap(int a,int b){
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    printf("a ====  %d,b ==== %d \n\n\n\n\n\n\n\n\n\n\n\n\n",a,b);
}



@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

  
    int a = 1024;
    int b = 4097;
    swap(a,b);
    
}


-(void)goldenRatio{

    static double number = 2;
    number = 1 / number + 1;
    [self goldenRatio];
    NSLog(@"%lf",number);
}




@end
