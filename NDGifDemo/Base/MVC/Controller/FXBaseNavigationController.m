//
//  FXBaseNavigationController.m
//  FZDJapp
//
//  Created by FeoniX on 2018/7/4.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseNavigationController.h"

@interface FXBaseNavigationController ()

@end

@implementation FXBaseNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    [self setNavigationBarHidden:NO animated:YES];
    
}

-(void)endRefreshing {
    [MBProgressHUD wb_hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
