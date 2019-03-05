//
//  UIView+MoreFunction.m
//  iOSFactory
//
//  Created by kevin on 2019/3/5.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "UIView+THMoreFunction.h"

@implementation UIView (THMoreFunction)



- (void)setBadgeValue:(NSString *)badgeValue {
    
    
    
    [self removeBadgeValue];
    //为0就不添加了
    if (badgeValue.integerValue < 1) {
        return;
    }



    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    tabBar.backgroundColor = [UIColor yellowColor];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = badgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;



    //寻找
    for (UIView *viewTab in tabBar.subviews) {

            for (UIView *subview in viewTab.subviews) {
        
                    NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        
                    if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                        [strClassName isEqualToString:@"_UIBadgeView"]) {
            
                            //从原视图上移除
                            [subview removeFromSuperview];
                            //
                            [self addSubview:subview];
                            subview.frame = CGRectMake(self.frame.size.width - subview.frame.size.width * 0.5, -subview.frame.size.height * 0.5,subview.frame.size.width, subview.frame.size.height);
                            break;
            
                        }
        
                }

        }
    
    
    
}

//从子视图移除角标
- (void)removeBadgeValue{
        for (UIView *subview in self.subviews) {
                NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
                if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                    [strClassName isEqualToString:@"_UIBadgeView"]) {
                        [subview removeFromSuperview];
                        break;
                    }
            }
}



@end
