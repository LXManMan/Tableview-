//
//  ViewController.m
//  Tableview点开表头展开
//
//  Created by chuanglong02 on 17/1/4.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXSectionModel.h"
#import "LXHeadView.h"
#import "LXCellModel.h"
#import "LXTableviewHeader.h"
static NSString *kCellIdentfier = @"UITableViewCell";
static NSString *kHeaderIdentifier = @"HeaderView";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionDataSources;
@property(nonatomic,strong)LXTableviewHeader *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Tableview三级展开";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCellIdentfier];
    [self.tableView registerClass:[LXHeadView class] forHeaderFooterViewReuseIdentifier:kHeaderIdentifier];
    
    LXTableviewHeader *header =[[LXTableviewHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    __weak ViewController *weakSelf = self;
    header.expandBlock = ^( BOOL isExpand)
    {
        [weakSelf.tableView reloadData];
    };
    self.tableView.tableHeaderView = header;
    self.headerView = header;
    self.tableView.tableFooterView =[UIView new];
    
    
}
- (NSMutableArray *)sectionDataSources {
    if (_sectionDataSources == nil) {
        _sectionDataSources = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < 20; ++i) {
            LXSectionModel *sectionModel = [[LXSectionModel alloc] init];
            sectionModel.isExpanded = NO;
            sectionModel.sectionTitle = [NSString stringWithFormat:@"section: %ld", i];
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            for (NSUInteger j = 0; j < 10; ++j) {
                LXCellModel *cellModel = [[LXCellModel alloc] init];
                cellModel.title = [NSString stringWithFormat:@"雪晟仿制：section=%ld, row=%ld", i, j];
                [itemArray addObject:cellModel];
            }
            sectionModel.cellModels = itemArray;
            
            [_sectionDataSources addObject:sectionModel];
        }
    }
    
    return _sectionDataSources;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headerView.isExpand ?self.sectionDataSources.count:0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      LXSectionModel *sectionModel = self.sectionDataSources[section];
    return sectionModel.isExpanded ? sectionModel.cellModels.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentfier
                                                            forIndexPath:indexPath];
    LXSectionModel *sectionModel = self.sectionDataSources[indexPath.section];
    LXCellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.textLabel.text = cellModel.title;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LXHeadView *view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
    LXSectionModel *sectionModel = self.sectionDataSources[section];
    
    view.model = sectionModel;
    view.enpandBlock = ^(BOOL isExpanded)
    {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:0];
    };
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
//cell  动画
#pragma mark 设置scale
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.frame.size.height + scrollView.contentInset.top;
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        CGFloat y = cell.center.y - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}
@end
