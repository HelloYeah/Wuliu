//
//  WuliuModel.h
//  WuLiu
//
//  Created by Sekorm on 2018/7/31.
//  Copyright © 2018年 Sekorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WuliuCellPositionMid,
    WuliuCellPositionTop,
    WuliuCellPositionTail,
} WuliuCellPosition;

@interface WuliuModel : NSObject
///时间
@property (nonatomic, copy) NSString *time;
///物流
@property (nonatomic, copy) NSString *context;
///行高
@property (nonatomic, assign) CGFloat rowHeight;
///区分第一行还是最后一行,默认中间
@property (nonatomic, assign) WuliuCellPosition wuliuCellPosition;

+ (NSArray *)modelArrayWithDictArray:(NSArray *)array;
@end
