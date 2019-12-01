//
//  NDDownloadDataProvide.h
//  NDGifDemo
//
//  Created by 140013 on 2019/12/1.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class  NDGifDemoItem;

@interface NDDownloadDataProvide : NSObject

/**
 下载中数组
 */
@property (nonatomic, strong, readonly) NSMutableArray *downloadingArray;
/**
 等待下载的"栈"，实际为数组
 */
@property (nonatomic, strong, readonly) NSMutableArray *waitingStack;

@property (nonatomic, strong) NSMutableArray *testArr;
+ (instancetype)shareManager;

- (BOOL)enableDownLoad;
- (void)handleItem:(NDGifDemoItem *)item;

- (void)addDownloadingItem:(NDGifDemoItem *)item;
- (void)removeDownloadedItem:(NDGifDemoItem *)item;


- (void)addWaitingItem:(NDGifDemoItem *)item ;
/**
 获取等待数组的“栈顶”元素
 */
- (NDGifDemoItem *)popWaitingStack;
@end

NS_ASSUME_NONNULL_END
