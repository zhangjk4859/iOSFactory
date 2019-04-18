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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //只要调用init  都会调用init with frame
    TableViewCell *cell = [[TableViewCell alloc] init];
    
//    TableViewCell *cell = [[TableViewCell alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    cell.backgroundColor = [UIColor redColor];
    
//    TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCell class]) owner:nil options:nil] lastObject];
    
    NSLog(@"%@",cell);
    
    [self.view addSubview:cell];
    
  
}





@end
