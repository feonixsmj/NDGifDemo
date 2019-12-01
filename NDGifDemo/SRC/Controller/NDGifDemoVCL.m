//
//  NDGifDemoVCL.m
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifDemoVCL.h"
#import "NDGifDemoModel.h"
#import "NDGifDemoCell.h"
#import "NDGifDownloadStrategy.h"

@interface NDGifDemoVCL ()
@property (nonatomic, strong) NDGifDownloadStrategy *gifStrategy;
@end

@implementation NDGifDemoVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [NDGifDemoModel new];
        self.gifStrategy = [[NDGifDownloadStrategy alloc] initWithTarget:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GIF 展示优化";
    [self registerTableCellWithNibClass:[NDGifDemoCell class]];
    //发起请求
    [self loadItem];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:UIBarButtonItemStyleDone target:self action:@selector(clean)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clean{
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    [manager.cache.memoryCache removeAllObjects];
    [manager.cache.diskCache removeAllObjects];
    
    
    [self.tableView reloadData];
}

- (void)loadItem{
    [self showLoading];
    
    __weak __typeof(self)weakSelf = self;
    [self.model loadItem:nil success:^(NSDictionary *dict) {
        [weakSelf loadSuccess];
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}

- (void)loadSuccess{
    [self endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.gifStrategy downloadGifImage];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //拖拽松开手指后是否在惯性减速中
    if (!decelerate) {
        //减速停止 shutableview停止滚动
        [self.gifStrategy downloadGifImage];
    }
}

#pragma mark------------------ UITabelViewDelegate ------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NDGifDemoItem *item = self.model.items[indexPath.row];
    
    NDGifDemoCell *cell =
        [tableView dequeueReusableCellWithIdentifier:[NDGifDemoCell reuseIdentifier]];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用缓存高度
    NDGifDemoItem *item = self.model.items[indexPath.row];
    return item.cellHeight;
}

@end
