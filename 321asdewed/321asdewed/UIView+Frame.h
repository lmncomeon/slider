//
//  UIView+Frame.h
//  YXCarLoanP
//
//  Created by HuangYingjie on 15/11/4.
//  Copyright © 2015年 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

- (void)removeAllSubviews;
- (void)setTapActionWithBlock:(void (^)(void))block;


@end
