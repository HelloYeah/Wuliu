//
//  WuliuModel.m
//  WuLiu
//
//  Created by Sekorm on 2018/7/31.
//  Copyright © 2018年 Sekorm. All rights reserved.
//

#import "WuliuModel.h"

@implementation WuliuModel

- (instancetype)initWithDict:(NSDictionary *)dict {    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray *)modelArrayWithDictArray:(NSArray *)array{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        WuliuModel *model = [[[WuliuModel alloc] init]  initWithDict:dict];
        [tempArray addObject:model];
    }
    return tempArray;
}

@end
