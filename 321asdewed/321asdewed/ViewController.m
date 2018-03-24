//
//  ViewController.m
//  321asdewed
//
//  Created by 栾美娜 on 2018/2/26.
//  Copyright © 2018年 Cindy. All rights reserved.
//

#import "ViewController.h"
#import "MNControl.h"
#import "MNSliderModel.h"


@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSlider];
}

- (void)addSlider
{
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < 8; i++) {
        
        if (i == 7 || i == 3 || i == 6 || i == 0) {
            [tmp addObject:[MNSliderModel sliderModelWithTitle:[NSString stringWithFormat:@"%d", i] available:NO]];
        } else {
            [tmp addObject:[MNSliderModel sliderModelWithTitle:[NSString stringWithFormat:@"%d", i] available:YES]];
        }
    }
    
    MNControl *control = [[MNControl alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 60)];
    control.titlesArray = tmp.copy;
    control.currentIndex = 2;
    [self.view addSubview:control];
    
}

@end
