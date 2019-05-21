//
//  TableViewCell.m
//  iOSFactory
//
//  Created by kevin on 2019/4/18.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "TableViewCell.h"

//加了 static 表明这个变量只分配一次，并且只服务于当前这个类，当前命名空间
//不加 static 编译器会认为这个变量分配多次，即使别的类访问不到，但是别的类有同名，也会被认为重复
//所以 static 就是 当前命名空间的一次 意思，不加 编译器就会认为多次 全局，报重复的错误
static NSString *ABC = @"123";

@implementation TableViewCell

//上面是代码创建的路线
// 1.
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    ABC = @"123123123";
    
    NSLog(@"%s",__func__);
    
    return self;
}

// 2.
-(instancetype)init{
    self = [super init];
    ABC;
    
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
