//
//  FightViewCell.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightViewCell : UITableViewCell


//Connections to the UI
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *heroValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *orcValueLbl;


@end
