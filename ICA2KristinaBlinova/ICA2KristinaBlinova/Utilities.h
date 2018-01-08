//
//  Utilities.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          UTILITIES
// Used for operations with records, such as combining the wo together
// Use: combining weapon and hero records together
//--------------------------------------------------------------------


#import "GeneralRecord.h"
#import "HeroRecord.h"
#import "GeneralRecord.h"

@interface Utilities : GeneralRecord

//Combine two hero records
//Further development: can be used to merge two heroes into one ultimate hero
-(HeroRecord*) sumRecordA:(HeroRecord*)recordA andRecordB:(HeroRecord*)recordB;

//Combine two general records
-(GeneralRecord*) sumGeneralRecordA:(GeneralRecord*)recordA andGeneralRecordB:(GeneralRecord*)recordB;

@end
