//
//  LXTableviewHeader.h
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXExpandBlock)(BOOL isExpand);
@interface LXTableviewHeader : UIView
@property(nonatomic, assign)BOOL isExpand;
@property(nonatomic,copy)LXExpandBlock expandBlock;
@end
