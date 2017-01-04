//
//  LXSectionModel.h
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXSectionModel : NSObject
@property (nonatomic, copy) NSString *sectionTitle;
// 是否是展开的
@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, strong) NSMutableArray *cellModels;
@end
