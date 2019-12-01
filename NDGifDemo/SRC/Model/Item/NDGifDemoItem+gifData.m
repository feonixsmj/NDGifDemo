//
//  NDGifDemoItem+gifData.m
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifDemoItem+gifData.h"

@interface NDGifDemoItem ()
@property (nonatomic, assign) BOOL gif_isLoading;
@property (nonatomic, strong) UIImageView *gif_imageView;
@end

@implementation NDGifDemoItem (gifData)

static dispatch_semaphore_t _lock;

- (BOOL)gif_isLoading{
    NSNumber *gifIsloading = (NSNumber *)objc_getAssociatedObject(self, @selector(gif_isLoading));
    return gifIsloading.floatValue;
}

- (void)setGif_isLoading:(BOOL)gif_isLoading{
    NSNumber *gifIsloading = [NSNumber numberWithBool:gif_isLoading];
    objc_setAssociatedObject(self, @selector(gif_isLoading), gifIsloading, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)gif_isPlaying{
    NSNumber *gifIsPlaying = (NSNumber *)objc_getAssociatedObject(self, @selector(gif_isPlaying));
    return gifIsPlaying.floatValue;
}

- (void)setGif_isPlaying:(BOOL)gif_isPlaying{
    NSNumber *gifIsPlaying = [NSNumber numberWithBool:gif_isPlaying];
    objc_setAssociatedObject(self, @selector(gif_isPlaying), gifIsPlaying, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)gif_progress{
    NSNumber *gifProgress = (NSNumber *)objc_getAssociatedObject(self, @selector(gif_progress));
    return [gifProgress floatValue];
}

- (void)setGif_progress:(float)gif_progress{
    NSNumber *gifProgress = [NSNumber numberWithFloat:gif_progress];
    objc_setAssociatedObject(self, @selector(gif_progress), gifProgress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)gif_image{
    return (UIImage *)objc_getAssociatedObject(self, @selector(gif_image));
}

- (void)setGif_image:(UIImage *)gif_image{
    objc_setAssociatedObject(self, @selector(gif_image), gif_image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)gif_imageView{
    return (UIImageView *)objc_getAssociatedObject(self, @selector(gif_imageView));
}

- (void)setGif_imageView:(UIImageView *)gif_imageView{
    objc_setAssociatedObject(self, @selector(gif_imageView), gif_imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)downloadGifImage:(NSURL *)imageURL {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    if (!self.gif_isLoading) {
        self.gif_imageView = [[UIImageView alloc] init];
        self.gif_isLoading = YES;
        self.gif_isPlaying = NO;
        
        @weakify (self)
        
        [self.gif_imageView fx_setImageWithURL:imageURL
                              placeholderImage:nil
                                       options:FXWebImageOptionAvoidSetImage
                                      progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            @strongify(self)
            float progress = (float)receivedSize / expectedSize;
            if (progress > 0.01f) {
                self.gif_progress = progress;
            }
        } completed:^(UIImage * _Nullable image, NSURL * _Nullable url, NSError * _Nullable error) {
            @strongify(self)
            self.gif_isLoading = NO;
            if (!error) {
                self.gif_image = image;
                self.gif_isPlaying = YES;
            }else{
                self.gif_image = nil;
                self.gif_progress = -1;
            }
            [[NSNotificationCenter defaultCenter]
                postNotificationName:NDGifDownLoadCompleteNotifKey object:self];
        }];
        
    }
    
    dispatch_semaphore_signal(_lock);
}

- (void)cancle{
    [self.gif_imageView yy_cancelCurrentImageRequest];
    self.gif_image = nil;
    self.gif_imageView = nil;
}

@end
