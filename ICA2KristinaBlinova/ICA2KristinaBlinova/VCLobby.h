//
//  VCLobby.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "heroRecord.h"

@interface VCLobby : UIViewController

@property (nonatomic) int currentHeroID;
@property (nonatomic) heroRecord* passedHeroRecord;

@property (nonatomic) NSMutableArray *ownedHeroes;


@end
