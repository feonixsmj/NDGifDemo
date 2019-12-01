//
//  NDGifVo.m
//  NDGifDemo
//
//  Created by 140013 on 2019/10/31.
//  Copyright © 2019 FeoniX. All rights reserved.
//

#import "NDGifVo.h"
#import "NDGifListVo.h"

@implementation NDGifVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"dataImgs" : [NDGifListVo class]};
}
@end
