//
//  NDGifDownloadStrategy.m
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifDownloadStrategy.h"
#import "NDGifDemoVCL.h"
#import "NDGifDemoItem.h"
#import "NDGifDemoCell.h"
#import "FXAnimatedImageView.h"
#import "NDDownloadManager.h"

@interface NDGifDownloadStrategy ()

@property (nonatomic, strong) NDDownloadManager *manager;
@end
@implementation NDGifDownloadStrategy

- (instancetype)initWithTarget:(id)target{
    if (self = [super initWithTarget:target]) {
        self.manager = [NDDownloadManager shareManager];
    }
    return self;
}

- (void)downloadGifImage {
    
    NDGifDemoVCL *target = (NDGifDemoVCL *)self.target;
    
    NSArray<NSIndexPath *> *indexPaths = [target.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in indexPaths) {
        @autoreleasepool {
            
            NSObject *obj = target.model.items[indexPath.row];
            
            if ([obj isKindOfClass:[NDGifDemoItem class]]) {
                
                NDGifDemoItem *item = (NDGifDemoItem *)obj;
                NDGifDemoCell *cell =
                    (NDGifDemoCell *)[target.tableView cellForRowAtIndexPath:indexPath];
                BOOL onlyOneCell = indexPaths.count == 1;
                if (onlyOneCell) {
                    [self.manager startDownloadTask:item callBack:^(BOOL hasCache, UIImage *image) {
                        if (hasCache) {
                            [cell displayGifImage:image];
                        } else {
                            [cell observerGifImage];
                        }
                    }];
                    break;
                }
                
                CGRect mainImageViewRect = cell.mainImageView.frame;
                
                CGRect mainImageViewRectInSuperView =
                    [cell.contentView convertRect:mainImageViewRect
                                           toView:[target.tableView superview]];
                
                CGRect intersectsRect = CGRectIntersection(mainImageViewRectInSuperView,target.tableView.frame);
                
                if (intersectsRect.size.height >= mainImageViewRect.size.height /2) {
                    
                    [self.manager startDownloadTask:item callBack:^(BOOL hasCache, UIImage *image) {
                        if (hasCache) {
                            [cell displayGifImage:image];
                        } else {
                            [cell observerGifImage];
                        }
                    }];
                }
            }
        }
    }
}
@end
