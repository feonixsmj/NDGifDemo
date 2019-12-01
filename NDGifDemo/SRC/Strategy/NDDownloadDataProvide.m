//
//  NDDownloadDataProvide.m
//  NDGifDemo
//
//  Created by 140013 on 2019/12/1.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDDownloadDataProvide.h"
#import "NDGifDemoItem.h"

@interface NDDownloadDataProvide ()

/**
 最大同时下载数，上限4，默认3
 */
@property (nonatomic, assign) NSInteger maxConcurrentLimit;
/**
 最大等待数，默认3
 */
@property (nonatomic, assign) NSInteger maxWaitLimit;


@property (nonatomic, strong, nonnull) dispatch_semaphore_t lock;
@end
@implementation NDDownloadDataProvide

+ (instancetype)shareManager
{
    static NDDownloadDataProvide *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxWaitLimit = 3;
        _maxConcurrentLimit = 3;
        
        _waitingStack = [NSMutableArray arrayWithCapacity:_maxWaitLimit];
        _downloadingArray = [NSMutableArray arrayWithCapacity:_maxConcurrentLimit];
        
        _lock = dispatch_semaphore_create(1);
    }
    return self;
}

- (BOOL)enableDownLoad{
    if (self.downloadingArray.count < _maxConcurrentLimit) {
        return YES;
    }
    return NO;
}

- (void)handleItem:(NDGifDemoItem *)item{
    if (self.downloadingArray.count < self.maxConcurrentLimit) {
        [self addDownloadingItem:item];
    } else {
        [self addWaitingItem:item];
    }
}


- (void)addDownloadingItem:(NDGifDemoItem *)item {
    FX_LOCK(_lock);
    if (![self.downloadingArray containsObject:item]) {
        [self.downloadingArray addObject:item];
    }
    
    FX_UNLOCK(_lock);
}

- (void)removeDownloadedItem:(NDGifDemoItem *)item{
    FX_LOCK(_lock);
    [self.downloadingArray removeObject:item];
    FX_UNLOCK(_lock);
}

- (void)addWaitingItem:(NDGifDemoItem *)item {
    
    if ([self.downloadingArray containsObject:item]) {
        return;//正在下载
    }
    FX_LOCK(_lock);
    if ([self.waitingStack containsObject:item]) {
        NSInteger index = [self.waitingStack indexOfObject:item];
        // 包含此项，且不是最后一项
        if (index != self.waitingStack.count - 1) {
            // 移动到最后一项
            [self.waitingStack removeObjectAtIndex:index];
            [self.waitingStack addObject:item];
        }
    } else {
        // 不包含，判断当前是否已经已经超过最大数
        if (self.waitingStack.count == self.maxWaitLimit) {
            //删除第一项, 加到最后一项
            [self.waitingStack removeObjectAtIndex:0];
            [self.waitingStack addObject:item];
        } else {
            [self.waitingStack addObject:item];
        }
    }
    
    FX_UNLOCK(_lock);
}

- (NDGifDemoItem *)popWaitingStack{
    if (self.waitingStack.count <= 0) {
        return nil;
    }
    FX_LOCK(_lock);
    
    NDGifDemoItem *topItem = (NDGifDemoItem *)self.waitingStack.lastObject;
    [self.waitingStack removeLastObject];
    FX_UNLOCK(_lock);
    return topItem;
    
}

@end
