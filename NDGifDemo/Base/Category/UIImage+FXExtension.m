//
//  UIImage+Extension.m
//
//  Created by mutouren on 2018/3/10.
//

#import "UIImage+FXExtension.h"

@implementation UIImage (FXExtension)

+ (UIImage *)fx_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect =CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
}

- (NSData *)fx_compressThreeTimesWithMaxLength:(NSUInteger)maxLength {
    maxLength = maxLength*1024;
    NSData *data = UIImageJPEGRepresentation(self, 0.5);
    if(data.length < maxLength*(1+0.1)) {
        return data;
    }
    
    data = UIImageJPEGRepresentation(self, 0.3);
    if(data.length < maxLength*(1+0.1)) {
        return data;
    }
    
    data = UIImageJPEGRepresentation(self, 0.1);
    
    return data;
}

- (NSData *)fx_compressWithMaxLength:(NSUInteger)maxLength {
    maxLength = maxLength*1024;
    // Compress by quality
    CGFloat compression = 1;

    NSData *data = UIImageJPEGRepresentation(self, compression);
    
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }

    //    NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    
    return data;
}

- (CGFloat)fx_getImageSize {
    NSData * imageData = UIImageJPEGRepresentation(self,1);
    
    return [imageData length]/1024;
}

- (UIImage *)fx_imageByScalingAspectFitMaxSize:(CGSize)targetSize color:(UIColor*)color alpha:(CGFloat)alpha {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint anchorPoint = CGPointZero;
    if(!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat xFactor = targetWidth / width;
        CGFloat yFactor = targetHeight / height;
        CGFloat scaleFactor = (xFactor < yFactor) ? xFactor : yFactor;
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(xFactor < yFactor) {
            anchorPoint.y = (targetHeight - scaledHeight) / 2;
        } else if(xFactor > yFactor){
            anchorPoint.x = (targetWidth - scaledWidth) / 2;
        }
    }
    
    CGRect anchorRect = CGRectZero;
//    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaledWidth;
    anchorRect.size.height = scaledHeight;
    UIGraphicsBeginImageContext(anchorRect.size);
//    UIGraphicsBeginImageContextWithOptions(anchorRect.size, YES, [UIScreen mainScreen].scale);
    
    [self drawInRect:anchorRect];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)fx_imageByFlipHorizontal {
    UIImageOrientation orientation = (self.imageOrientation + 4) % 8;
    return [[UIImage alloc] initWithCGImage:self.CGImage scale:self.scale orientation:orientation];
}

- (UIImage *)fx_imageByFlipVertical {
    UIImageOrientation orientation = (self.imageOrientation + 4) % 8;
    orientation += orientation % 2 == 0 ? 1 : -1;
    return [[UIImage alloc] initWithCGImage:self.CGImage scale:self.scale orientation:orientation];
}

@end
