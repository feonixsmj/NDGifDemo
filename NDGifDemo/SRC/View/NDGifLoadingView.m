//
//  NDGifLoadingView.m
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifLoadingView.h"
#import "FXAnimatedImageView.h"

@interface NDGifLoadingView ()

@property (nonatomic, assign) float progress;
@property (nonatomic, strong) FXAnimatedImageView *background;
@property (nonatomic, strong) FXAnimatedImageView *logo;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, assign) bool annular;
@property (nonatomic, strong) UIColor *color;
/**
 是否显示进度值
 */
@property (nonatomic ,assign) BOOL isShowProgressLabel;

@end

@implementation NDGifLoadingView

- (id)initWithAnnular:(BOOL)annular color:(UIColor *)color {
    self = [super init];
    if (self) {
        _annular = annular;
        _color = color;
        self.isShowProgressLabel = annular;
        
        if (annular) {
            self.background.backgroundColor = [UIColor blackColor];
            self.background.alpha = 0.5;
        }
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.width/2;
    self.layer.masksToBounds = YES;
    
    self.background.frame = self.bounds;
    [self addSubview:self.background];
    
    self.progressLabel.frame = self.bounds;
    [self addSubview:self.progressLabel];
    
    self.logo.center = self.background.center;
    [self addSubview:self.logo];
    
    
    if (!self.progressLayer) {
        float lineWidth = self.annular?5:self.width/2;
        float radius = self.width/2;
        UIColor * color = self.color?self.color:[UIColor whiteColor];
        self.progressLayer = [self createRingLayerWithCenter:self.logo.center radius:radius lineWidth:lineWidth color:color];
        [self.layer addSublayer:self.progressLayer];
        self.progressLayer.cornerRadius = self.width / 2;
        [self update:0];
    }
    
}

- (void)setIsShowProgressLabel:(BOOL)isShowProgressLabel {
    _isShowProgressLabel = isShowProgressLabel;
    [self.progressLabel setHidden:!isShowProgressLabel];
    if (isShowProgressLabel) {
        self.logo.alpha = 0;
    } else {
        self.logo.alpha = 1;
    }
}

- (CAShapeLayer *)createRingLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    
    CGRect rect ;
    if (self.annular) {
        rect = CGRectMake(0, 0, self.width, self.height);
    } else {
        rect = CGRectMake(self.width/4, self.height/4, self.width/2, self.height/2);
    }
    
    UIBezierPath *smoothedPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.contentsScale = [[UIScreen mainScreen] scale];
    slice.frame = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    slice.fillColor = [UIColor clearColor].CGColor;
    slice.strokeColor = color.CGColor;
    slice.lineWidth = lineWidth;
    slice.lineCap = kCALineCapButt;
    slice.lineJoin = kCALineJoinRound;
    slice.path = smoothedPath.CGPath;
    return slice;
}

- (void)update:(float)progress animated:(BOOL)animated {
    //默认更新进度隐藏logo
    self.logo.hidden = YES;
    
    if (self.progress > progress) {
        self.progress = 0;
        self.logo.hidden = NO;
    } else {
        if (progress <= 0) {
            self.progress = 0;
            self.logo.hidden = NO;
        } else if (progress >= 1) {
            self.progress = 0;
            self.hidden = YES;
        } else {
            self.progress = progress;
        }
    }
    
    if (animated) {
        self.progressLayer.strokeEnd = self.progress;
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.progressLayer.strokeEnd = self.progress;
        [CATransaction commit];
    }
    
    self.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(self.progress*100)];
}


- (void)update:(float)progress {
    [self update:progress animated:YES];
}

- (void)setProgress:(float)progress {
    _progress = progress;
}

- (void)backgroundImage:(UIImage *)image {
    self.background.image = image;
}

- (void)firstFrameImage:(UIImage *)image {
    self.logo.image = image;
}

- (FXAnimatedImageView *)background {
    if (!_background) {
        _background = [[FXAnimatedImageView alloc] init];
    }
    return _background;
}

- (FXAnimatedImageView *)logo {
    if (!_logo) {
        _logo = [[FXAnimatedImageView alloc] init];
        _logo.size = CGSizeMake(50, 50);
    }
    return _logo;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:11];
        [_progressLabel setHidden:YES];
    }
    return _progressLabel;
}


@end
