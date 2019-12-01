//
//  FXBaseModel.m
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseModel.h"

@implementation FXBaseModel

static dispatch_semaphore_t _semaphore;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = 10;
        self.pageNumber = 1;
        self.isEnd = NO;
        self.items = [NSMutableArray array];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *dict))success
         failure:(void (^)(NSError *error))failure{
    
}

- (void)clean{
    [self resetPageNumber];
    self.items = [NSMutableArray arrayWithCapacity:20];
}

- (void)resetPageNumber {
    self.pageSize = 10;
    self.pageNumber = 1;
}

- (void)plusPageNumber{
    self.pageNumber += 1;
}

- (void)insertObject:(id)obj
               index:(NSUInteger)index{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _semaphore = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    [self.items insertObject:obj atIndex:index];
    dispatch_semaphore_signal(_semaphore);
}

- (void)delecteObject:(id)obj{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _semaphore = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    [self.items removeObject:obj];
    dispatch_semaphore_signal(_semaphore);
}

@end
