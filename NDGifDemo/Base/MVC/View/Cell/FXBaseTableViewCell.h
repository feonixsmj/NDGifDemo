//
//  FXBaseTableViewCell.h
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXBaseTableViewCell : UITableViewCell

- (void)customInit;

//子类重写
+ (NSString *)reuseIdentifier;
@end
