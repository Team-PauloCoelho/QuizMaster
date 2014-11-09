//
//  CustomTableViewCell.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/9/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,1.5,40,40);
    float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        self.textLabel.frame = CGRectMake(55,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(55,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
    }
}

@end
