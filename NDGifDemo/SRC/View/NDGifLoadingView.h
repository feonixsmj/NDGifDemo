//
//  NDGifLoadingView.h
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDGifLoadingView : UIView

/**
 初始化是否为环形
 
 @param annular 是否为环形
 @param color   环形颜色
 @return OMTLoadingView
 */
- (id)initWithAnnular:(BOOL)annular color:(UIColor *)color;


/**
 更新进度
 @param progress 进度值(0 ~ 1)
 */
- (void)update:(float)progress;


/**
 是否需要动画
 */
- (void)update:(float)progress animated:(BOOL)animated;
/**
 设置背景图
 
 @param image 背景图
 */
- (void)backgroundImage:(UIImage *)image;


/**
 设置首帧图
 
 @param image 首帧图
 */
- (void)firstFrameImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
