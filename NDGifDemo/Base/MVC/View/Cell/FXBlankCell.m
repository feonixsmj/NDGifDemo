//
//  FXBlankCell.m
//  FZLYZXY
//
//  Created by FeoniX on 2019/2/28.
//  Copyright © 2019 FeoniX All rights reserved.
//

#import "FXBlankCell.h"

@implementation FXBlankCell

- (void)customInit{
    self.contentView.backgroundColor = [UIColor fx_colorWithHexString:@"0xf7f7f5"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
