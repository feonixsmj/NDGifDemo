//
//  FXBaseViewController.h
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBaseModel.h"


@interface FXBaseViewController : UIViewController

@property (nonatomic, strong) FXBaseModel *model;
@property (nonatomic, strong) NSDictionary *parameterDict;

- (void)showLoading;
- (void)endRefreshing;
/**
 策略类回调controller 参数
 
 @param dataDict 回调参数
 */
- (void)callBackStrategyData:(NSDictionary *)dataDict;


@end
