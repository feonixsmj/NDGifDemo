//
//  FXBaseTableViewCell.m
//  FZDJapp
//
//  Created by FeoniX on 2018/6/26.
//  Copyright © 2018年 FeoniX All rights reserved.
//

#import "FXBaseTableViewCell.h"

@implementation FXBaseTableViewCell

//子类重写
+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setStyle];
        [self customInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStyle];
    [self customInit];
}

- (void)setStyle{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)customInit{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
