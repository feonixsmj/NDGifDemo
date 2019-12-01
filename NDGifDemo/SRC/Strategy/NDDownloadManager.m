//
//  NDDownloadManager.m
//  NDGifDemo
//
//  Created by 140013 on 2019/12/1.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDDownloadManager.h"
#import "NDGifDemoItem.h"
#import "NDGifDemoItem+gifData.h"
#import "NDDownloadDataProvide.h"
#import "FXWebImageManager.h"

@interface NDDownloadManager ()

//@property (nonatomic, strong) NSMutableArray *<##>;

@property (nonatomic, strong) NDDownloadDataProvide *dataProvide;
@property (nonatomic, copy) NDDownloadManagerBlock callBack;
@end

@implementation NDDownloadManager

+ (instancetype)shareManager
{
    static NDDownloadManager *manager = nil;
    
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
        self.dataProvide = [NDDownloadDataProvide shareManager];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadCompletion:)
                                                     name:NDGifDownLoadCompleteNotifKey
                                                   object:nil];
    }
    return self;
}

- (void)startDownloadTask:(NDGifDemoItem *)item callBack:(NDDownloadManagerBlock)block{
    self.callBack = block;
    BOOL hasCache =
        [[FXWebImageManager sharedManager] imageInCacheWithURL:[NSURL URLWithString:item.gifUrl]];
    
    if (hasCache) {
        UIImage *image = [[YYWebImageManager sharedManager].cache getImageForKey:item.gifUrl];
        block (YES,image);
    } else {
        
        // 正在下载数组不足最大下载数，加入下载队列
        if ([self.dataProvide enableDownLoad]) {
//            NSLog(@"当前下载队列%@",self.dataProvide.downloadingArray);
//            NSLog(@"待下载队列%@",self.dataProvide.waitingStack);
            [self.dataProvide addDownloadingItem:item];
            [self startDownload:item];
        } else {
            //加入 待下载数组
            [self.dataProvide addWaitingItem:item];
            //
//            NSLog(@"下载队列已满%@",self.dataProvide.downloadingArray);
//            NSLog(@"带下载队列%@",self.dataProvide.waitingStack);
        }
        block (NO,nil);
    }
        
}

- (void)startDownload:(NDGifDemoItem *)item{
    if (!item) {
        return;
    }
    [item downloadGifImage:[NSURL URLWithString:item.gifUrl]];
}

#pragma mark - NSNotification

- (void)downloadCompletion:(NSNotification *)notification{
    //不用关心成功还是失败
    NDGifDemoItem *item = (NDGifDemoItem *)notification.object;
    
    [self.dataProvide removeDownloadedItem:item];
//    NSLog(@"下载队列===%@",self.dataProvide.downloadingArray);
    //从待下载中取出栈顶一项下载
//    NSLog(@"待下载前%@",self.dataProvide.waitingStack);
    NDGifDemoItem *topWaitingItem = [self.dataProvide popWaitingStack];
//    NSLog(@"待下载后%@",self.dataProvide.waitingStack);
    if (topWaitingItem) {
//        NSLog(@"完成%ld 添加%ld",item.index,topWaitingItem.index);
        [self.dataProvide addDownloadingItem:topWaitingItem];
        [self startDownload:topWaitingItem];
    }
    
    
}
@end
