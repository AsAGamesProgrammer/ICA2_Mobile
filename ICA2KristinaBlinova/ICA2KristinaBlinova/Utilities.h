//
//  Utilities.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "GeneralRecord.h"
#import "HeroRecord.h"
#import "GeneralRecord.h"

@interface Utilities : GeneralRecord

-(HeroRecord*) sumRecordA:(HeroRecord*)recordA andRecordB:(HeroRecord*)recordB;

-(GeneralRecord*) sumGeneralRecordA:(GeneralRecord*)recordA andGeneralRecordB:(GeneralRecord*)recordB;

@end
