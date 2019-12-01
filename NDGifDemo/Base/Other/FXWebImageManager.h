//
//  FXWebImageManager.h
//  NDGifDemo
//
//  Created by 140013 on 2019/10/30.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXWebImageManager : NSObject

+ (instancetype)sharedManager;

/**
 根据URL判断图片是否在缓存中

 @param url url
 @return YES 是 NO 否
 */
- (BOOL)imageInCacheWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
