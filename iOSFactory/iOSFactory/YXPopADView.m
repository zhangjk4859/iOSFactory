//
//  YXPopBannerView.m
//  PopBannerDemo
//
//  Created by maoyuxiang on 2017/2/27.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXPopADView.h"
#import <Masonry.h>


#define kADViewHeight 405/667.0 * [UIScreen mainScreen].bounds.size.height
#define kADViewWidth 320/375.0 * [UIScreen mainScreen].bounds.size.width

#define kADHeight 335/667.0 * [UIScreen mainScreen].bounds.size.height
#define kADWidth 300/375.0 * [UIScreen mainScreen].bounds.size.width

#define kOffsetY 0//广告插件离Y轴中心的偏移量

@interface YXPopADView()

@property(strong, nonatomic) UIView   *blackBackgroundView;
@property(strong, nonatomic) UIView   *whiteBackgroundView;
@property(strong, nonatomic) UILabel  *titleLabel;
@property(strong, nonatomic) UILabel  *contentLabel;
/** 广告图片 */
@property(strong, nonatomic) UIImageView *QRImageView;
@property(strong, nonatomic) UIButton *saveButton;
@property(strong, nonatomic) UILabel  *bottomLabel;
@property(strong, nonatomic) UIView   *lineView;
/**
 是否需要动画显示和隐藏（动画方向为从上往下）
 */
@property(assign, nonatomic) BOOL animated;

@end


@implementation YXPopADView

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.QRImageView.image = [UIImage imageNamed:imageName];
}

-(void)setWechatName:(NSString *)wechatName{
    _wechatName = wechatName;
    self.contentLabel.text = [NSString stringWithFormat:@"微信号:%@",wechatName];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化UI
        [self initUI];
    }
    return self;
}


#pragma mark - 自定义方法

/**
 初始化UI
 */
- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    //黑色背景
    self.blackBackgroundView = [[UIView alloc]init];
    self.blackBackgroundView.backgroundColor = [UIColor blackColor];
    self.blackBackgroundView.alpha = 0.3;
    self.blackBackgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnPressed:)];
    [self.blackBackgroundView addGestureRecognizer:tap];
    [self addSubview:self.blackBackgroundView];
    

    //白色的区域
    self.whiteBackgroundView = [[UIView alloc]init];
    self.whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    self.whiteBackgroundView.layer.cornerRadius = 10;
    self.whiteBackgroundView.layer.masksToBounds = YES;
    [self addSubview:self.whiteBackgroundView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"添加客服微信";
    self.titleLabel.textColor = [UIColor blackColor];//hex: #333333
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.whiteBackgroundView addSubview:self.titleLabel];
    

    self.contentLabel = [UILabel new];
    self.contentLabel.text = @"微信号:";
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = [UIColor lightGrayColor];//#999999
    [self.whiteBackgroundView addSubview:self.contentLabel];
    
    self.QRImageView = [[UIImageView alloc]init];
    self.QRImageView.contentMode = UIViewContentModeScaleToFill;
    [self.whiteBackgroundView addSubview:self.QRImageView];
    
    self.bottomLabel = [UILabel new];
    self.bottomLabel.text = @"扫一扫二维码,添加我微信";
    self.bottomLabel.font = [UIFont systemFontOfSize:14];
    self.bottomLabel.adjustsFontSizeToFitWidth = YES;
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.textColor = [UIColor lightGrayColor];//#999999
    [self.whiteBackgroundView addSubview:self.bottomLabel];
    
    
    //底部分割线
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self.whiteBackgroundView addSubview:self.lineView];
    
    
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.goNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton setTitle:@"保存二维码" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.whiteBackgroundView addSubview:self.saveButton];
    
    

}


/**
 初始化页面约束
 */
- (void)makeViewContraints{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsZero);
    }];
    
    [self.blackBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    // 宽度是屏幕宽的  0.717
    [self.whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.717);
        make.height.mas_equalTo(self.whiteBackgroundView.mas_width).multipliedBy(1.28);
        make.center.equalTo(self);
        
    }];

    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteBackgroundView).offset(-10);
        make.bottom.equalTo(self.whiteBackgroundView);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(55);
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.3);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.saveButton.mas_top);
    }];

    
    [self.QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //0.5725
        make.width.height.equalTo(self.whiteBackgroundView.mas_width).multipliedBy(0.5725);
        make.centerX.equalTo(self.whiteBackgroundView);
        make.centerY.equalTo(self.whiteBackgroundView).multipliedBy(0.95);
        
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QRImageView.mas_left);
        make.width.equalTo(self.QRImageView.mas_width);
        make.height.mas_equalTo(21);
        make.bottom.equalTo(self.QRImageView.mas_top).offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QRImageView.mas_left);
        make.width.equalTo(self.QRImageView.mas_width);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.contentLabel.mas_top).offset(-5);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QRImageView.mas_left);
        make.width.equalTo(self.QRImageView.mas_width);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.QRImageView.mas_bottom).offset(10);
    }];

    
}


- (void)btnPressed:(UITapGestureRecognizer *)tap{
    
    if (self.saveBlock) {
        self.saveBlock();
    }
    
    //关闭弹窗广告插件
    [self closeADWithAnimated:self.animated];
    
}


/**
 弹窗广告插件

 @param animated 是否需要动画
 */
- (void)popADWithAnimated:(BOOL)animated{
    
    self.animated = animated;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    //初始化约束，并及时刷新约束
    [self makeViewContraints];
    [self layoutIfNeeded];
    
    //更新约束
    [self.whiteBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(- kOffsetY);
    }];
    
    if(self.animated){
        //添加弹簧动画  0.3
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:100 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self layoutIfNeeded];
        } completion:nil];
    }
}



/**
 关闭弹窗广告插件
 
 @param animated 是否需要动画
 */
- (void)closeADWithAnimated:(BOOL)animated{
    
    //更新约束
    [self.whiteBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(CGRectGetHeight([UIScreen mainScreen].bounds)/2.0 + kADViewHeight + kOffsetY);
    }];
    
    if(animated){
        [UIView animateWithDuration:0.5 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else{
        [self removeFromSuperview];
    }
}


@end
