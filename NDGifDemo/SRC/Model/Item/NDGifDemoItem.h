//
//  NDGifDemoItem.h
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FXGIFWidthConst (FX_SCREEN_WIDTH - 20)

NS_ASSUME_NONNULL_BEGIN

@interface NDGifDemoItem : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *firstFrameImageName;
@property (nonatomic, copy) NSString *gifUrl;
@property (nonatomic, copy) NSString *gifID;

@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
