//
//  ViewController.m
//  iOSFactory
//
//  Created by kevin on 2018/11/13.
//  Copyright © 2018 jumu. All rights reserved.
//

#import "ViewController.h"
#import "AlgorithmObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *originalArray = @[@"5",@"5",@"3",@"4",@"90",@"21",@"1",@"55",@"12",@"32",@"88"];
    NSLog(@"%@",[AlgorithmObject selectionSort:originalArray]);
    
}


@end
