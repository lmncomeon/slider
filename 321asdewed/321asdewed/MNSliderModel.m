//
//  MNSliderModel.m
//  321asdewed
//
//  Created by 栾美娜 on 2018/3/1.
//  Copyright © 2018年 Cindy. All rights reserved.
//

#import "MNSliderModel.h"

@implementation MNSliderModel

- (instancetype)initWithTitle:(NSString *)title available:(BOOL)available
{
    self = [super init];
    if (self) {
        _title     = title;
        _available = available;
    }
    return self;
}

+ (instancetype)sliderModelWithTitle:(NSString *)title available:(BOOL)available
{
    return [[MNSliderModel alloc] initWithTitle:title available:available];
}

@end
