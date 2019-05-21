//
//  APEHomePraticeDataController.h
//  iOSFactory
//
//  Created by kevin on 2019/5/13.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "APEBaseDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface APEHomePraticeDataController : APEBaseDataController
// 1
@property (nonatomic, strong, nonnull, readonly) NSArray *openSubjects;
// 2
//- (void)requestSubjectDataWithCallback:(nonnull APECompletionCallback)callback;

@end

NS_ASSUME_NONNULL_END
