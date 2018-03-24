//
//  MNSliderModel.h
//  321asdewed
//
//  Created by 栾美娜 on 2018/3/1.
//  Copyright © 2018年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNSliderModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL available;

+ (instancetype)sliderModelWithTitle:(NSString *)title available:(BOOL)available;

@end
