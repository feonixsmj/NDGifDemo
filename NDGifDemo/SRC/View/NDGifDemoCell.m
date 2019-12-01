//
//  NDGifDemoCell.m
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifDemoCell.h"
#import "NDGifDemoItem.h"
#import "FXAnimatedImageView.h"
#import "NDGifDemoItem+gifData.h"
#import "NDGifLoadingView.h"
#import "FXWebImageManager.h"
#import <KVOController.h>

@interface NDGifDemoCell ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageViewWidthConst;

@property (nonatomic, strong) NDGifLoadingView *loadingView;
@end

@implementation NDGifDemoCell

- (void)customInit{
    
    [self.mainImageView addSubview:self.loadingView];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.center.mas_equalTo(self.mainImageView);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.mainImageView.image = nil;
    _item.gif_isPlaying = NO;
}

- (void)setItem:(NDGifDemoItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    
    self.mainImageViewWidthConst.constant = FXGIFWidthConst;
    [self downLoadFirstFrameImage];
}

/**
 下载首帧图
 */
- (void)downLoadFirstFrameImage {
    
    if (_item.gif_isPlaying) {
        return;
    }
    
    if (_item.gif_progress <= 0 || _item.gif_progress == 1) {
        [self.loadingView setHidden:NO];
        [self.loadingView update:0 animated:NO];
    } else {
        //滑回来的时候使用存储的进度
        [self.loadingView update:_item.gif_progress];
    }
    
    // 加载本地图片
    UIImage *image = [UIImage imageNamed:_item.firstFrameImageName];
    if (!image) {
        NSLog(@"图片出现异常");
    }
    self.mainImageView.image =image ;
}

- (void)displayGifImage:(UIImage *)image{
    self.mainImageView.image = image;
    self.loadingView.hidden = YES;
}

- (void)observerGifImage{
    [self addHomeModelObserver];
    if (_item.gif_progress <= 0) {
        _item.gif_progress = 0.01;
    }

}

- (void)addHomeModelObserver{
    //FBKVOController 不用手动释放
    @weakify (self)
    [self.KVOController observe:self.item
                        keyPath:@"gif_progress"
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object,
                                  NSDictionary<NSString *,id> * _Nonnull change) {
                              
                              NDGifDemoItem *observedItem = (NDGifDemoItem *)object;
                              [weak_self dealGifProgressByItem:observedItem dictionary:change];
                          }];
    
    [self.KVOController observe:self.item
                        keyPath:@"gif_image"
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object,
                                  NSDictionary<NSString *,id> * _Nonnull change) {
                @strongify(self)
                NDGifDemoItem *observedItem = (NDGifDemoItem *)object;
                //检查是否是自己的model更新，防止复用问题
                if (![observedItem.gifID isEqualToString:self.item.gifID]) {
                    return;
                }
        
                UIImage *image = (UIImage *)change[NSKeyValueChangeNewKey];
                if (image && ![image isKindOfClass:[NSNull class]]) {//成功
                    [self.loadingView setHidden:YES];
                    self.mainImageView.image = self.item.gif_image;
                } else {//失败
                    [self.loadingView setHidden:NO];
                    [self.loadingView update:0 animated:NO];
                }
    }];
}

- (void)dealGifProgressByItem:(NDGifDemoItem *)observedItem
                   dictionary:(NSDictionary<NSString *,id> *)change{
    //检查是否是自己的model更新，防止复用问题
    if (![observedItem.gifID isEqualToString:self.item.gifID]) {
        return;
    }
    
    float progress = 0;
    
    if (change[NSKeyValueChangeNewKey] && ![change[NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]]) {
        progress = [change[NSKeyValueChangeNewKey] floatValue];
        if (progress > 0) {
            [self.loadingView update:progress];
            [self.loadingView setHidden:NO];
            if (progress == 1.0) {
                [self.loadingView setHidden:YES];
            }
        } else {
            [self.loadingView setHidden:NO];
            [self.loadingView update:0 animated:NO];
        }
    }
}

#pragma mark - lazy load
- (NDGifLoadingView *)loadingView {
    
    if (!_loadingView) {
        _loadingView = [[NDGifLoadingView alloc] init];
        [_loadingView backgroundImage:[UIImage imageNamed:@"icon_gif_background"]];
        [_loadingView firstFrameImage:[UIImage imageNamed:@"icon_gif_logo"]];
        [_loadingView setHidden:YES];
    }
    
    return _loadingView;
}

@end
