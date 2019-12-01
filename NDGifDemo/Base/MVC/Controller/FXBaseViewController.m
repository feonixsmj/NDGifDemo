//
//  FXBaseViewController.m
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseViewController.h"

typedef NS_ENUM(NSUInteger, FZLYBaseVCLNavStyle) {
    FZLYBaseVCLNavStyleDefault,
    FZLYBaseVCLNavStyleWhite
};


@interface FXBaseViewController ()

@property (nonatomic, assign) FZLYBaseVCLNavStyle style;

@property (nonatomic, assign) BOOL hiddenNavigationBar;
@property (nonatomic, assign) BOOL isTransparentBar;

@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation FXBaseViewController

- (void)setParameterDict:(NSDictionary *)parameterDict{
    _parameterDict = parameterDict;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FXBaseModel alloc] init];
        self.hiddenNavigationBar = NO;
        self.isTransparentBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
}

- (void)setStyle:(FZLYBaseVCLNavStyle)style{
    _style = style;
    
    if (style == FZLYBaseVCLNavStyleDefault) {
        
        [self setNavigationBarBGColor:[UIColor fx_colorWithHexString:@"#015293"]];
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    } else if (style == FZLYBaseVCLNavStyleWhite){
        
        [self setNavigationBarBGColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        
        UIImage *bgimg = [UIImage fx_imageWithColor:[UIColor fx_colorWithHexString:@"0xE3E3E3"] size:CGSizeMake(1, 1)];
        [self.navigationController.navigationBar setShadowImage:bgimg];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //控制是否显示导航栏
    if (self.hiddenNavigationBar){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self addNavigationBar];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    self.style = FZLYBaseVCLNavStyleDefault;
}

- (void)setNavigationBarBGColor:(UIColor *)navigationBarBGColor {
    
    UIImage *bgimg = [UIImage fx_imageWithColor:navigationBarBGColor size:CGSizeMake(1, 1)];
    
    UIImage *image = self.isTransparentBar ? [UIImage new] : bgimg;
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)addNavigationBar{
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"base_nav_left_btn"] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnDidClicked)];
        
        self.navigationItem.leftBarButtonItem = leftBtn;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)backBtnDidClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoading {
    [MBProgressHUD wb_showActivity];
}

-(void)endRefreshing {
    [MBProgressHUD wb_hideHUD];
}


- (void)callBackStrategyData:(NSDictionary *)dataDict{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
