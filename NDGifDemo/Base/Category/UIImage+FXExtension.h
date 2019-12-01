//
//  UIImage+Extension.h
//
//  Created by mutouren on 2018/3/10.
//

#import <UIKit/UIKit.h>

@interface UIImage (FXExtension)

+ (UIImage *)fx_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 最多压缩三次，一次系数 0.5，一次0.3，一次 0.1
- (NSData *)fx_compressThreeTimesWithMaxLength:(NSUInteger)maxLength;

/**
 调整图片大小
 
 @param maxLength 最大的大小 KB
 @return 返回图片data
 */
- (NSData *)fx_compressWithMaxLength:(NSUInteger)maxLength;

/**
 返回图片大小 KB
 
 @return 返回图片大小 KB
 */
- (CGFloat)fx_getImageSize;


/**
 将图片等比例缩放到指定大小，UIViewContentModeScaleAspectFit 的效果
 
 @param targetSize 目标大小
 @return 缩放后的图片
 */
- (UIImage *)fx_imageByScalingAspectFitMaxSize:(CGSize)targetSize color:(UIColor*)color alpha:(CGFloat)alpha;

/// 水平翻转（左右镜像）
- (UIImage *)fx_imageByFlipHorizontal;

/// 垂直翻转（上下镜像）
- (UIImage *)fx_imageByFlipVertical;



@end
