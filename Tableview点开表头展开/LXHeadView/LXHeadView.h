//
//  LXHeadView.h
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSectionModel;
typedef void (^LXHeaderViewExpandBlock)(BOOL isExpand);
@interface LXHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)LXSectionModel *model;
@property(nonatomic,copy)LXHeaderViewExpandBlock enpandBlock;
@end
