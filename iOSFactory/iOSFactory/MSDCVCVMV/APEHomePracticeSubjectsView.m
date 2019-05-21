//
//  APEHomePracticeSubjectsView.m
//  iOSFactory
//
//  Created by kevin on 2019/5/13.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "APEHomePracticeSubjectsView.h"



@interface APEHomePracticeSubjectsView ()

@end

@implementation APEHomePracticeSubjectsView


- (void)bindDataWithViewModel:(nonnull APEHomePracticeSubjectsViewModel *)viewModel {
//    self.viewModel = viewModel;
//    self.backgroundColor = viewModel.backgroundColor;
//    [self.collectionView reloadData];
//    [self setNeedsUpdateConstraints];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:
(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (0 <= indexPath.row && indexPath.row < self.viewModel.cellViewModels.count) {
        APEHomePracticeSubjectsCollectionCellViewModel *vm =
        self.viewModel.cellViewModels[indexPath.row];
//        [cell bindDataWithViewModel:vm];
    }
    return cell;
}

@end
