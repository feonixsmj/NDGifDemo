//
//  NDGifDemoCell.h
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "FXBaseTableViewCell.h"

@class FXAnimatedImageView,NDGifDemoItem;

NS_ASSUME_NONNULL_BEGIN

@interface NDGifDemoCell : FXBaseTableViewCell

@property (weak, nonatomic) IBOutlet FXAnimatedImageView *mainImageView;
@property (nonatomic, strong) NDGifDemoItem *item;

- (void)displayGifImage:(UIImage *)image;
- (void)observerGifImage;
@end

NS_ASSUME_NONNULL_END
