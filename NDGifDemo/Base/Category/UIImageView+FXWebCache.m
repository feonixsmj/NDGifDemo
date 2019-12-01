                                                                                                                                   //
//  UIImageView+FXWebCache.m
//  NDGifDemo
//
//  Created by 140013 on 2019/11/3.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "UIImageView+FXWebCache.h"

@implementation UIImageView (FXWebCache)

- (NSString *)fx_localImageName {
    NSString *pageName = objc_getAssociatedObject(self, @selector(fx_localImageName));
    return pageName;
}

- (void)setFx_localImageName:(NSString *)fx_localImageName {
    objc_setAssociatedObject(self, @selector(fx_localImageName), fx_localImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (fx_localImageName.length > 0) {
        self.image = [UIImage imageNamed:fx_localImageName];
    }
}

- (void)fx_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(FXWebImageOptions)options
                  progress:(nullable FXWebImageProgressBlock)progressBlock
                 completed:(nullable FXWebImageCompletionBlock)completedBlock {
    
    YYWebImageOptions yyWebImageOption = [self converFXEnumToYYEnum:options];
    [self yy_setImageWithURL:url
                 placeholder:placeholder
                     options:yyWebImageOption
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        if (progressBlock) {
                            progressBlock(receivedSize,expectedSize);
                        }
                    }
                   transform:NULL
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url,
                               YYWebImageFromType from, YYWebImageStage stage,
                               NSError * _Nullable error) {
                      if (completedBlock) {
                          completedBlock(image,url,error);
                      }
                  }];
    
}

- (YYWebImageOptions)converFXEnumToYYEnum:(FXWebImageOptions)options{
    switch (options) {
        case FXWebImageOptionDefault:{
            return YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur;
            break;
        }
        case FXWebImageOptionAvoidSetImage:{
            return YYWebImageOptionAvoidSetImage;
            break;
        }
        default:
            return YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur;
            break;
    }
}

@end
