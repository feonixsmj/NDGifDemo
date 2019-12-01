//
//  NDGifDownloadStrategy.h
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "FXBaseStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDGifDownloadStrategy : FXBaseStrategy

/**
 下载当前GIF图片漏出50%
 */
- (void)downloadGifImage;

@end

NS_ASSUME_NONNULL_END
