//
//  NDDownloadManager.h
//  NDGifDemo
//
//  Created by 140013 on 2019/12/1.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NDDownloadManagerBlock)(BOOL hasCache,UIImage *image);

@class NDGifDemoItem;

NS_ASSUME_NONNULL_BEGIN

@interface NDDownloadManager : NSObject

+ (instancetype)shareManager;

/// 开始下载
- (void)startDownloadTask:(NDGifDemoItem *)item
                 callBack:(NDDownloadManagerBlock)block;
@end

NS_ASSUME_NONNULL_END
