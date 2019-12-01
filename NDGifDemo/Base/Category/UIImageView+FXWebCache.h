//
//  UIImageView+FXWebCache.h
//  NDGifDemo
//
//  Created by 140013 on 2019/11/3.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

typedef NS_OPTIONS(NSUInteger, FXWebImageOptions){
    FXWebImageOptionDefault =
    YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur,
    FXWebImageOptionAvoidSetImage = YYWebImageOptionAvoidSetImage
};

typedef void(^FXWebImageProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void (^FXWebImageCompletionBlock)(UIImage * _Nullable image,
                                          NSURL * _Nullable url,
                                          NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FXWebCache)

@property (nonatomic, copy) NSString *fx_localImageName;

- (void)fx_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(FXWebImageOptions)options
                  progress:(nullable FXWebImageProgressBlock)progressBlock
                 completed:(nullable FXWebImageCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
