//
//  MNControl.m
//  321asdewed
//
//  Created by 栾美娜 on 2018/2/28.
//  Copyright © 2018年 Cindy. All rights reserved.
//

#import "MNControl.h"
#import "MNSliderModel.h"
#import "UIView+Frame.h"

static const CGFloat grayViewH = 10;
static const CGFloat pinViewWH = 30;

@interface MNControl()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, strong) UIImageView *pinView;

@property (nonatomic, strong) UIView *buttonsView;
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonsArray;

@end

@implementation MNControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [self addSubview:_container];
        
        _buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_container.frame), CGRectGetWidth(_container.frame), self.frame.size.height - CGRectGetHeight(_container.frame))];
        [self addSubview:_buttonsView];
        
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(pinViewWH*0.5, (_container.frame.size.height - grayViewH)*0.5, self.frame.size.width-pinViewWH, grayViewH)];
        _grayView.backgroundColor = [UIColor grayColor];
        _grayView.layer.masksToBounds = YES;
        _grayView.layer.cornerRadius = _grayView.frame.size.height*0.5;
        [_container addSubview:_grayView];
        
        _orangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, _grayView.frame.size.height)];
        _orangeView.backgroundColor = [UIColor orangeColor];
        [_grayView addSubview:_orangeView];
        
        CGFloat pinViewX  = 0;
        CGFloat pinViewY  = 0;
        _pinView = [[UIImageView alloc] initWithFrame:CGRectMake(pinViewX, pinViewY, pinViewWH, pinViewWH)];
        _pinView.image = [UIImage imageNamed:@"attributes_slider_indicator"];
        _pinView.userInteractionEnabled = YES;
        [_container addSubview:_pinView];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)];
        [_pinView addGestureRecognizer:panGR];

        [_container addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)]];
    }
    return self;
}

- (void)setTitlesArray:(NSArray<MNSliderModel *> *)titlesArray
{
    if (!titlesArray || titlesArray.count == 0) {
        return;
    }
    
    _titlesArray = titlesArray;
    
    [self.buttonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat btnW = 100;
    CGFloat btnH = CGRectGetHeight(self.buttonsView.frame);
    CGFloat btnCenterX = CGRectGetWidth(self.grayView.frame) / (titlesArray.count-1);
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titlesArray[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.buttonsView addSubview:btn];
        [self.buttonsArray addObject:btn];
        
        // frame
        if (titlesArray.count != 1)
        {
            if (i == 0)
            {
                btn.frame = CGRectMake(0, 0, self.pinView.frame.size.width, btnH);
            }
            else if (i == titlesArray.count - 1)
            {
                btn.frame = CGRectMake(self.buttonsView.frame.size.width-self.pinView.frame.size.width, 0, self.pinView.frame.size.width, btnH);
            }
            else
            {
                btn.frame  = CGRectMake(0, 0, btnW, btnH);
                btn.center = CGPointMake(CGRectGetMinX(self.grayView.frame) + i*btnCenterX, CGRectGetHeight(self.buttonsView.frame)*0.5);
            }
        }
        else
        {
            btn.frame  = CGRectMake(0, 0, btnW, btnH);
            btn.center = CGPointMake(CGRectGetWidth(self.buttonsView.frame)*0.5, CGRectGetHeight(self.buttonsView.frame)*0.5);
        }
        
        // 颜色
        btn.enabled = titlesArray[i].available;
        
    }
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex >= self.titlesArray.count) {
        return;
    }
    
    _currentIndex = currentIndex;
    
    self.buttonsArray[currentIndex].selected = YES;
    
    if (self.titlesArray.count == 1) {
        self.orangeView.width = self.grayView.width*0.5;
        self.pinView.centerX  = self.buttonsView.width*0.5;
        
        return;
    }
    
    CGFloat calibration   = self.grayView.width/(self.titlesArray.count-1);
    self.orangeView.width = currentIndex *calibration;
    self.pinView.centerX  = self.grayView.left + currentIndex *calibration;
    
}

- (void)panGR:(UIPanGestureRecognizer *)sender
{
    // 不处理
    if (self.titlesArray.count == 1) { return; }
    
    CGPoint poi = [sender locationInView:self.grayView];
    
    if (sender.state == UIGestureRecognizerStateEnded  ||
        sender.state == UIGestureRecognizerStateFailed ||
        sender.state == UIGestureRecognizerStateCancelled)
    {
        [self handleAnimationWithPoint:poi];
    }
    else if (sender.state == UIGestureRecognizerStateBegan ||
             sender.state == UIGestureRecognizerStateChanged)
    {
        [self animationWithPoint:poi];
    }

}

- (void)tapGR:(UITapGestureRecognizer *)sender
{
    // 不处理
    if (self.titlesArray.count == 1) { return; }
    
    CGPoint point = [sender locationInView:self.grayView];
    [self handleAnimationWithPoint:point];
}

- (void)handleAnimationWithPoint:(CGPoint)poi
{
    CGFloat calculateX = poi.x;
    if (poi.x <= 0.00)
    {
        calculateX = 0.00;
    }
    else if (poi.x > CGRectGetWidth(self.grayView.frame))
    {
        calculateX = CGRectGetWidth(self.grayView.frame);
    }
    
    // 组装可用的结点
    NSMutableArray *valuesArr = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < self.titlesArray.count; i++) {
        
        if (self.titlesArray[i].available) {
            [valuesArr addObject:@(self.grayView.width/(self.titlesArray.count -1) * i)];
        }
    }
    
    NSInteger index = 0;
    while (index < valuesArr.count) {
        if (calculateX > [valuesArr[index] doubleValue]) {
            index++;
        } else {
            break;
        }
    }
    
    if (index >= valuesArr.count)
    {
        index--;
    }
    else if (index != 0)
    {
        double right = [valuesArr[index] doubleValue];
        double left = [valuesArr[index-1] doubleValue];
        
        if (calculateX-left < right - calculateX) {
            index = index-1;
        }
    }
    
    
    [UIView animateWithDuration:0.5f animations:^{
        self.orangeView.width = [valuesArr[index] doubleValue];
        self.pinView.left = [valuesArr[index] doubleValue];
        
        NSInteger adjustIndex = self.orangeView.width/(self.grayView.width/(self.titlesArray.count -1));
        
        self.buttonsArray[adjustIndex].selected = YES;
        self.buttonsArray[self.currentIndex].selected = NO;
        self.currentIndex = adjustIndex;
    }];
}

- (void)animationWithPoint:(CGPoint)poi
{
    CGFloat calculateX = poi.x;
    if (poi.x <= 0.00) {
        calculateX = 0.00;
    } else if (poi.x > CGRectGetWidth(self.grayView.frame)) {
        calculateX = CGRectGetWidth(self.grayView.frame);
    }
    
    self.orangeView.width = calculateX;
    
    self.pinView.left = calculateX;
    
    NSLog(@"%.2f", calculateX /self.grayView.frame.size.width);
    
}



@end
