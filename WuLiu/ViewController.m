//
//  ViewController.m
//  WuLiu
//
//  Created by Sekorm on 2018/7/31.
//  Copyright © 2018年 Sekorm. All rights reserved.
//

#import "ViewController.h"
#import "WuliuModel.h"
#import "WuliuCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.dataSource = [WuliuModel modelArrayWithDictArray:dataArray];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WuliuCell class] forCellReuseIdentifier:@"WuliuCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WuliuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WuliuCell"];
    WuliuModel *model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        model.wuliuCellPosition = WuliuCellPositionTop;
    }else if (indexPath.row == self.dataSource.count - 1){
        model.wuliuCellPosition = WuliuCellPositionTail;
    }else {
        model.wuliuCellPosition = WuliuCellPositionMid;
    }
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WuliuModel *model = self.dataSource[indexPath.row];
    if (model.rowHeight > 0) {
        return model.rowHeight;
    }
    WuliuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WuliuCell"];
    cell.model = model;
    return model.rowHeight;
}

+ (BOOL)isPhoneNum:(NSString *)phoneNum
{
    //判断移动手机号
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    //固话及小灵通
    NSString *PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestcm evaluateWithObject:phoneNum] == YES)
        || ([regextestphs evaluateWithObject:phoneNum] == YES)){
        return YES;
    }
    return NO;
}


@end
