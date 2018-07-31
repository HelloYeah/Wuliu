//
//  WuliuCell.m
//  WuLiu
//
//  Created by Sekorm on 2018/7/31.
//  Copyright © 2018年 Sekorm. All rights reserved.
//

#import "WuliuCell.h"
#import "UIView+Frame.h"

/***  当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface WuliuCell()
///时间线
@property (nonatomic, strong) UIView *timeLine;

///时间线上的小圆点
@property (nonatomic, strong) UIView *cirlePoint;
///时间
@property (nonatomic, strong) UILabel *timeLabel;
///物流
@property (nonatomic, strong) UILabel *contextLabel;
@end

@implementation WuliuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    
    self.timeLine = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 1, 60)];
    self.timeLine.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
    [self.contentView addSubview:self.timeLine];
    
    self.cirlePoint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
    self.cirlePoint.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
    [self.contentView addSubview:self.cirlePoint];
    self.cirlePoint.layer.cornerRadius = 3;
    self.cirlePoint.layer.masksToBounds = YES;
    self.cirlePoint.centerX = 20 + self.timeLine.width * 0.5;
    
    self.contextLabel = [[UILabel alloc] init];
    self.contextLabel.font = [UIFont systemFontOfSize:13];
    self.contextLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contextLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
    [self.contentView addSubview:self.timeLabel];
}

- (void)setModel:(WuliuModel *)model {
    
    _model = model;
    
    self.contextLabel.text = model.context;
    self.contextLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
    self.contextLabel.size = [self.contextLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH - 60, [UIFont systemFontOfSize:13].lineHeight * 3)];
    self.contextLabel.left = 40;
    self.contextLabel.top = 8;
    
    self.timeLabel.text = model.time;
    [self.timeLabel sizeToFit];
    self.timeLabel.left = 40;
    self.timeLabel.top = self.contextLabel.bottom + 4;
    
    model.rowHeight = self.timeLabel.bottom + 8;
    self.timeLine.top = 0;
    self.timeLine.height = model.rowHeight;
    self.cirlePoint.centerY = model.rowHeight * 0.5;
    
    if (model.wuliuCellPosition == WuliuCellPositionTop) {
        self.timeLine.top = model.rowHeight * 0.5;
        self.timeLine.height = model.rowHeight * 0.5;
        self.contextLabel.textColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1];
    }else if (model.wuliuCellPosition == WuliuCellPositionTail){
        self.timeLine.height = model.rowHeight * 0.5;
    }
}

@end
