//
//  FXBaseModel.h
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseModel : NSObject

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isEnd;
/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *items;



/**
 插入对象到items

 @param obj 对象
 @param index 位置
 */
- (void)insertObject:(id)obj
               index:(NSUInteger)index;

/**
 从items中删除对象
 
 @param obj 对象
 */
- (void)delecteObject:(id)obj;
/**
 网络请求

 @param parameterDict 参数
 @param success 回调
 @param failure 回调
 */
- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure;

/**
 重置页数并且清空数组
 */
- (void)clean;

/**
 重置页数
 */
- (void)resetPageNumber;


/**
 上拉成功 页数+1
 */
- (void)plusPageNumber;
@end
