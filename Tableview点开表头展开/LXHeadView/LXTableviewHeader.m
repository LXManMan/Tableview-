//
//  LXTableviewHeader.m
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXTableviewHeader.h"
@interface LXTableviewHeader()
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation LXTableviewHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_expand"]];
        self.arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 15, 8);
        [self addSubview:self.arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(clickExpand:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.frame = CGRectMake(0, 0, w, 44);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, 44)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor colorWithRed:0.47 green:0.83 blue:0.98 alpha:1];

        
    }
    return self;
}
-(void)clickExpand:(UIButton *)sender
{
    self.isExpand  =! self.isExpand;
    [UIView animateWithDuration:0.25 animations:^{
        if (self.isExpand) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }else
        {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    if (self.expandBlock) {
        self.expandBlock(self.isExpand);
    }

    
}
@end
