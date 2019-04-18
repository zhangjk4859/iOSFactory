//
//  TableViewCell.m
//  iOSFactory
//
//  Created by kevin on 2019/4/18.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

//上面是代码创建的路线
// 1.
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    NSLog(@"%s",__func__);
    
    return self;
}

// 2.
-(instancetype)init{
    self = [super init];
    
    
    NSLog(@"%s",__func__);
    
    
    return self;
}





//所以下面的方法是xib的路线

//先从xib文件解压
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    NSLog(@"%s",__func__);
    
    return self;
}


//解压后干点别的事，比如替换
-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    self = [super awakeAfterUsingCoder:aDecoder];
     NSLog(@"%s",__func__);
    return self;
}

//完成加载以后做点别的事
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__func__);
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
