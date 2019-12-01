//
//  FXBaseTableViewController.m
//  FZDJapp
//
//  Created by FeoniX on 2018/7/2.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseTableViewController.h"
#import "FXBaseTableViewCell.h"

@interface FXBaseTableViewController ()

@end

@implementation FXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self createTableView];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:[self tableRect] style:UITableViewStylePlain];
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        tableView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    
    [self.view addSubview:self.tableView];
}


- (CGRect)tableRect {
    return CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
}

- (void)registerTableCellWithNibClass:(Class )nibClass {
    NSString *nibName = NSStringFromClass(nibClass);
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]
         forCellReuseIdentifier:nibName];
}

- (void)registerTableCellWithCellClass:(Class )cellClass {
    
    [self.tableView registerClass:cellClass
           forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerTableCellWithNibClass:(Class )nibClass reuseIdentifier:(NSString *)reuseIdentifier {
    NSString *nibName = NSStringFromClass(nibClass);
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]
         forCellReuseIdentifier:reuseIdentifier];
}

- (void)registerTableCellWithCellClass:(Class )cellClass reuseIdentifier:(NSString *)reuseIdentifier {
    [self.tableView registerClass:cellClass
           forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark------------------ UITabelViewDelegate ------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;  /** 子类会重写*/
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
