//
//  VCFight.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralRecord.h"

@interface VCFight : UIViewController

@property (nonatomic) NSMutableArray* heroes;
@property (nonatomic) GeneralRecord* currentOrcRecord;
@property (nonatomic) NSInteger battleNumber;

@end
