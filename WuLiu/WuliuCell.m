//
//  WuliuCell.m
//  WuLiu
//
//  Created by Sekorm on 2018/7/31.
//  Copyright © 2018年 Sekorm. All rights reserved.
//

#import "WuliuCell.h"
#import "UIView+Frame.h"
#import "YYText.h"

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
@property (nonatomic, strong) YYLabel *contextLabel;
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
    
    self.contextLabel = [[YYLabel alloc] init];
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
    
    UIColor *contextColor;
    if (model.wuliuCellPosition == WuliuCellPositionTop) {
        contextColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1];
    }else {
        contextColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:model.context attributes:@{NSForegroundColorAttributeName:contextColor}];
    
    NSArray * phoneArray = [self getPhoneNumbersFromString:model.context];
    for (NSString *phoneStr in phoneArray) {

        [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:251.0f/255.0f green:162.0f/255.0f blue:44.0f/255.0f alpha:1.0f] range:[model.context rangeOfString:phoneStr]];
        YYTextHighlight *highlight = [YYTextHighlight new];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSString *str=[[NSString alloc]initWithFormat:@"tel:%@",phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        };
        [text yy_setTextHighlight:highlight range:[model.context rangeOfString:phoneStr]];
    }
    
    self.contextLabel.attributedText = text;
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
    }else if (model.wuliuCellPosition == WuliuCellPositionTail){
        self.timeLine.height = model.rowHeight * 0.5;
    }
}

- (NSArray *) getPhoneNumbersFromString:(NSString *)str {
    
    NSError* error = nil;
    NSString* regulaStr = @"(([0-9]{11})|((400|800)([0-9\\-]{7,10})|(([0-9]{4}|[0-9]{3})(-| )?)?([0-9]{7,8})((-| |转)*([0-9]{1,4}))?))";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    NSMutableArray* numbers = [NSMutableArray arrayWithCapacity:arrayOfAllMatches.count];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [str substringWithRange:match.range];
        [numbers addObject:substringForMatch];
        
    }
    return numbers;
}

@end
