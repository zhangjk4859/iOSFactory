//
//  THCommonWordsView.m
//  TopHoldFirmBargain
//
//  Created by kevin on 2019/2/18.
//  Copyright © 2019 Agan. All rights reserved.
//

#import "THCommonWordsView.h"
#import <Masonry.h>

@interface THCommonWordsView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UILabel *alertLabel;
@property(nonatomic,strong)UIButton *doneButton;
@property(nonatomic,strong)UIButton *middleButton;
@property(nonatomic,strong)UIButton *editButton;
@end

@implementation THCommonWordsView

#pragma mark getters && setters

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark view lifes ++++++++++++++++++++++++++++++++++++
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.dataArray addObjectsFromArray:@[@"你好，请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍请稍等1",@"你好，请稍等2",@"你好，请稍等3",@"你好，请稍等4",@"你好，请稍等5",@"你好，请稍等6",@"你好，请稍等7",@"你好，请稍等8",@"你好，请稍等9",@"你好，请稍等10"]];
        
        
        
        [self setupSubviews];
    }
    return self;
}


#pragma mark views++++++++++++++++++++++++++++++++++++
-(void)setupSubviews{
    
    
    UIView *barView = [UIView new];
    [self addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(49);
    }];
    
    UIView *lineView = [UIView new];
    [barView addSubview:lineView];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(barView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleButton setTitle:@"+新增常用语" forState:0];
    //@"#EC3627"
    [middleButton setTitleColor:[UIColor redColor] forState:0];
    middleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [middleButton addTarget:self action:@selector(addCommonWordsAction) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:middleButton];
    [middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(barView);
        make.height.equalTo(barView);
        make.width.equalTo(barView).multipliedBy(0.4);
    }];
    self.middleButton = middleButton;
    
    
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"完成" forState:0];
    //@"#EC3627"
    [doneButton setTitleColor:[UIColor redColor] forState:0];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [barView addSubview:doneButton];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(barView);
        make.height.equalTo(barView);
        make.width.equalTo(barView).multipliedBy(0.4);
    }];
    doneButton.hidden = YES;
    [doneButton addTarget:self action:@selector(setEditMode) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = doneButton;
    
    
    //@"nav_ico_set_skin"
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setImage:[UIImage imageNamed:@"nav_ico_set_skin"] forState:0];
    [barView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(barView);
        make.right.mas_equalTo(-18);
    }];
    [rightButton addTarget:self action:@selector(setEditMode) forControlEvents:UIControlEventTouchUpInside];
    self.editButton = rightButton;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [UIView new];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(barView.mas_top);
    }];
    
    //添加一个暂无常用语
    self.alertLabel = [UILabel new];
    [self addSubview:self.alertLabel ];
    self.alertLabel.text = @"暂无常用语";
    self.alertLabel.textColor = [UIColor lightGrayColor];
    self.alertLabel.font = [UIFont systemFontOfSize:13];
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 25));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-49);
    }];
}



#pragma mark actions++++++++++++++++++++++++++++++++++++
-(void)addCommonWordsAction{
    NSLog(@"增加常用语");
}

-(void)editAction:(UIButton *)button{
    button.tag;
    NSLog(@"编辑常用语");
    NSLog(@"%@", [NSString stringWithFormat:@"%d",button.tag]);
}

-(void)setEditMode{
    static BOOL isEdit = YES;
    self.doneButton.hidden = !isEdit;
    self.middleButton.hidden = isEdit;
    self.editButton.hidden = isEdit;
    [self.tableView setEditing:isEdit animated:YES];
    isEdit = !isEdit;
    
}



#pragma mark delegates ############################################

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray.count) {
        self.alertLabel.hidden = YES;
    }else{
        self.alertLabel.hidden = NO;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //右边加一个按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [cell.contentView addSubview:button];
        [button addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.mas_equalTo(-10);
        }];
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }

    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.tag = indexPath.row;

        }
    }
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--",self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    

    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.hidden = !tableView.editing;
        }
    }
    
    
}

//实现单行删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.hidden = !tableView.editing;
        }
    }
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

//实现上下拖动
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return UITableViewCellEditingStyleInsert;
//}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
     [tableView reloadData];
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:sourceIndexPath];
//    for (UIView *subview in cell.contentView.subviews) {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            subview.tag = destinationIndexPath.row;
//
//        }
//    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
