//
//  APEHomePraticeViewController.m
//  iOSFactory
//
//  Created by kevin on 2019/5/13.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "APEHomePraticeViewController.h"
#import "APEHomePraticeDataController.h"     //data controller
#import "APEHomePracticeSubjectsView.h"      //view
#import "APEHomePracticeSubjectsViewModel.h" //view model
@interface APEHomePraticeViewController ()

@property (nonatomic, strong, nullable) APEHomePracticeSubjectsView *subjectsView;
@property (nonatomic, strong, nullable) APEHomePraticeDataController *dataController;

@property (nonatomic, strong, nullable) UIScrollView *contentView;

@end

@implementation APEHomePraticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupContentView];
}

- (void)setupContentView {
    self.contentView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contentView];
    
   
    self.subjectsView = [[APEHomePracticeSubjectsView alloc] init];
    self.subjectsView.delegate = self;
    [self.contentView addSubview:self.subjectsView];
    // Layout Views ...
}

- (void)fetchSubjectData {
    //告诉视图控制器 去加载数据
//    [self.dataController requestSubjectDataWithCallback:^(NSError *error) {
//        if (error == nil) {
//            [self renderSubjectView];
//        }
//    }];
}

- (void)renderSubjectView {
    APEHomePracticeSubjectsViewModel *viewModel =
    [APEHomePracticeSubjectsViewModel viewModelWithSubjects:self.dataController.openSubjects];
    [self.subjectsView bindDataWithViewModel:viewModel];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
