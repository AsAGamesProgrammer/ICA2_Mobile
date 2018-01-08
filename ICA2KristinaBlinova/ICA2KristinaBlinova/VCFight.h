//
//  VCFight.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//


//--------------------------------------------------------------------
//                          OVERVIEW
// View controller for a fighting screen
//--------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "orcRecord.h"

@interface VCFight : UIViewController

//Array of heroes
@property (nonatomic) NSMutableArray* heroes;

//Current orc
@property (nonatomic) orcRecord* currentOrcRecord;

//Number of battle
@property (nonatomic) NSInteger battleNumber;

@end
