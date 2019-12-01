//
//  FXBaseTableViewController.h
//  FZDJapp
//
//  Created by FeoniX on 2018/7/2.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseViewController.h"

@class FXBaseTableViewCell;

@interface FXBaseTableViewController : FXBaseViewController
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


- (CGRect)tableRect;

- (void)registerTableCellWithNibClass:(Class)nibClass;
- (void)registerTableCellWithCellClass:(Class)cellClass;
- (void)registerTableCellWithNibClass:(Class)nibClass reuseIdentifier:(NSString *)reuseIdentifier;
- (void)registerTableCellWithCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier;
@end
