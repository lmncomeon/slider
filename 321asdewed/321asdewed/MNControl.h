//
//  MNControl.h
//  321asdewed
//
//  Created by 栾美娜 on 2018/2/28.
//  Copyright © 2018年 Cindy. All rights reserved.
// 

#import <UIKit/UIKit.h>

@class MNSliderModel;

@interface MNControl : UIControl

@property (nonatomic, strong) NSArray <MNSliderModel *> *titlesArray;
@property (nonatomic, assign) NSInteger currentIndex;
@end
