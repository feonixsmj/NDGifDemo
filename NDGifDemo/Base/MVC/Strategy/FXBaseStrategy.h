//
//  FXBaseStrategy.h
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXBaseStrategy : NSObject

@property (nonatomic, weak) id target;

- (instancetype)initWithTarget:(id) target;

@end

NS_ASSUME_NONNULL_END
