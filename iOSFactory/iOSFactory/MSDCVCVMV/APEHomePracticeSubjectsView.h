//
//  APEHomePracticeSubjectsView.h
//  iOSFactory
//
//  Created by kevin on 2019/5/13.
//  Copyright © 2019 jumu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APEHomePracticeSubjectsViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface APEHomePracticeSubjectsView : UIView
@property (nonatomic, strong, nullable, readonly) APEHomePracticeSubjectsViewModel *viewModel;
@property (nonatomic, weak, nullable) id delegate;

- (void)bindDataWithViewModel:(nonnull APEHomePracticeSubjectsViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
