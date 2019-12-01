//
//  NDGifListVo.h
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDGifListVo : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *phash;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float width;

@end

NS_ASSUME_NONNULL_END
