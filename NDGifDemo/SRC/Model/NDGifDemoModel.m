//
//  NDGifDemoModel.m
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDGifDemoModel.h"
#import "NDGifVo.h"
#import "NDGifListVo.h"

@interface NDGifDemoModel()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_queue_t dataQueue;
@property (nonatomic, strong) NSMutableDictionary *itemDict;
@end

@implementation NDGifDemoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //全局并发队列
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //串行队列，处理数据增
        _dataQueue = dispatch_queue_create("com.nd.gif.data.queue", DISPATCH_QUEUE_SERIAL);
        _itemDict = [NSMutableDictionary dictionaryWithCapacity:28];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
    
    dispatch_async(_queue, ^{
        [self loadLocalDefaultData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.items.count > 0) {
                if (success) {
                    success(nil);
                }
            } else {
                if (failure) {
                    failure(nil);
                }
            }
        });
    });
}

- (void)loadLocalDefaultData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
        return;
    }

    if (dict) {
        NDGifVo *vo = [NDGifVo mj_objectWithKeyValues:dict];
        [self wrapperItem:vo];
    }
    
}

/// 异步线程封装数据
- (void)wrapperItem:(NDGifVo *)vo{

    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:28];
    //并发处理数据
    dispatch_apply(vo.dataImgs.count, _queue, ^(size_t index) {
        @autoreleasepool {
            NDGifListVo *listVo = vo.dataImgs[index];
            NDGifDemoItem *item = [[NDGifDemoItem alloc] init];
            item.index = index;
            item.gifUrl = listVo.url;
            item.gifID = listVo.phash;
            item.firstFrameImageName = [self getLocalImageName:listVo.url];
            [self calculationItemHeight:item byGifListVo:listVo];
            
            NSString *key = [NSString stringWithFormat:@"%ld",index];
            [self itemDictSetValue:item forKey:key];
        }
    });
    //dispatch_apply 结束，按序取回数据
    [vo.dataImgs enumerateObjectsUsingBlock:^(NDGifListVo * _Nonnull obj, NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        NSString *key = [NSString stringWithFormat:@"%ld",idx];
        [muArr addObject:self.itemDict[key]];
    }];

    self.items = muArr;
}

/// 根据url获取本地图片名称
/// @param urlPath url
- (NSString *)getLocalImageName:(NSString *)urlPath{
    
    NSURL *url = [NSURL URLWithString:urlPath];
    NSString *lastPathComponent = url.lastPathComponent;
    NSMutableString *muStr = [NSMutableString stringWithString:lastPathComponent];
    [muStr replaceCharactersInRange:NSMakeRange(url.lastPathComponent.length - 4, 4)
                         withString:@".jpg"];
    return [NSString stringWithString:muStr];
}


/// 临时安全存放数据
- (void)itemDictSetValue:(id)value forKey:(NSString *)key{
    
    dispatch_sync(self.dataQueue, ^{
        self.itemDict[key] = value;
    });
}

/// 计算行高
- (void)calculationItemHeight:(NDGifDemoItem *)item
                  byGifListVo:(NDGifListVo *)listVo{
    
    CGFloat sale = (CGFloat)listVo.width/(CGFloat)listVo.height;
    CGFloat imageWidthConst = FXGIFWidthConst;
    
    CGFloat imageW = imageWidthConst;
    CGFloat imageH = ceil(imageW / sale + 10);
    
    item.cellHeight = imageH;
}

@end
