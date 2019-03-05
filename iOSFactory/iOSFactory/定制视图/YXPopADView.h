//
//  YXPopBannerView.h
//  PopBannerDemo
//
//  Created by maoyuxiang on 2017/2/27.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^savePhotoBlock)(void);

/**
  首页弹窗广告插件
 */
@interface YXPopADView : UIView

@property(nonatomic,copy)NSString *wechatName;

@property(nonatomic,copy)NSString *imageName;

/** 点击去看看按钮之后的回调 */
@property(copy, nonatomic) savePhotoBlock saveBlock;

/**
 弹出广告插件

 @param animated 是否需要动画
 */
- (void)popADWithAnimated:(BOOL)animated;

@end
