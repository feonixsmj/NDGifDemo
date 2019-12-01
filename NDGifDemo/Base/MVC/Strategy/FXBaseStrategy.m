//
//  FXBaseStrategy.m
//  NDGifDemo
//
//  Created by 140013 on 2019/11/4.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "FXBaseStrategy.h"

@implementation FXBaseStrategy

- (instancetype)initWithTarget:(id)target{
    
    if (self = [super init]) {
        self.target = target;
    }
    
    return self;
}
@end
