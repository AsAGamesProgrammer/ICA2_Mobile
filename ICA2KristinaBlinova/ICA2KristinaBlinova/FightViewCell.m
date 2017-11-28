//
//  FightViewCell.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "FightViewCell.h"

@implementation FightViewCell

//Synthesizing variables from the header
@synthesize heroValueLbl = _heroValueLbl;
@synthesize orcValueLbl = _orcValueLbl;
@synthesize iconImg = _iconImg;



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
