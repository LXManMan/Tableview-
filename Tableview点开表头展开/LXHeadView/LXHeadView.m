//
//  LXHeadView.m
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXHeadView.h"
#import "LXSectionModel.h"
@interface LXHeadView()
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation LXHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super  initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_expand"]];
        self.arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 15, 8);
        [self.contentView addSubview:self.arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(0, 0, w, 44);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, 44)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor purpleColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, w, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
    }
    return self;
}
-(void)setModel:(LXSectionModel *)model
{
    if (_model != model) {
        _model = model;
    }
    
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    }else
    {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    self.titleLabel.text = model.sectionTitle;
}
- (void)onExpand:(UIButton *)sender
{
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }else
        {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    if (self.enpandBlock) {
        self.enpandBlock(self.model.isExpanded);
    }
    
}
@end
