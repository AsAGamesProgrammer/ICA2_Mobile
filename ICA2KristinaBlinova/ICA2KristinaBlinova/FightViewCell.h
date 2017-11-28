//
//  FightViewCell.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *statLbl;
@property (nonatomic, weak) IBOutlet UILabel *heroValueLbl;
@property (nonatomic, weak) IBOutlet UILabel *orcValueLbl;
@property (nonatomic, weak) IBOutlet UIImageView *iconImg;

@end
