//
//  FXWebImageManager.m
//  NDGifDemo
//
//  Created by 140013 on 2019/10/30.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "FXWebImageManager.h"
#import "YYWebImageManager.h"
#import "YYMemoryCache.h"
#import "YYDiskCache.h"
#import "YYWebImageOperation.h"

@implementation FXWebImageManager

+ (instancetype)sharedManager {
    static FXWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (BOOL)imageInCacheWithURL:(NSURL *)url {
    NSString *cacheKey = [[YYWebImageManager sharedManager] cacheKeyForURL:url];
    if ([[YYImageCache sharedCache].memoryCache objectForKey:cacheKey]) {
        return YES;
    }
    
    if ([[YYImageCache sharedCache].diskCache objectForKey:cacheKey]) {
        return YES;
    }
    return NO;
}
@end
