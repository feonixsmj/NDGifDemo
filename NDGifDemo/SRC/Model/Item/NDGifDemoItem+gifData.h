//
//  NDGifDemoItem+gifData.h
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifDemoItem.h"

@interface NDGifDemoItem (gifData)

@property (nonatomic, assign) float gif_progress;
@property (nonatomic, strong) UIImage *gif_image;

/**
 gif 是否处于播放中
 */
@property (nonatomic, assign) BOOL gif_isPlaying;

- (void)downloadGifImage:(NSURL *)imageURL;

@end

