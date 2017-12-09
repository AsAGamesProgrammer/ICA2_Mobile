//
//  Utilities.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

//Combine two HERORECORD instances into a new one
-(HeroRecord*) sumRecordA:(HeroRecord*)recordA andRecordB:(HeroRecord*)recordB
{
    HeroRecord* sumRecord = [[HeroRecord alloc] init];
    sumRecord.strength = recordA.strength+recordB.strength;
    sumRecord.agility = recordA.agility+recordB.agility;
    sumRecord.intelect = recordA.intelect+recordB.intelect;
    sumRecord.defense = recordA.defense+recordB.defense;
    
    return sumRecord;
}

//Combine two GENERALRECORD instances into a new one
-(GeneralRecord*) sumGeneralRecordA:(GeneralRecord*)recordA andGeneralRecordB:(GeneralRecord*)recordB
{
    GeneralRecord* sumRecord = [[GeneralRecord alloc] init];
    sumRecord.strength = recordA.strength+recordB.strength;
    sumRecord.agility = recordA.agility+recordB.agility;
    sumRecord.intelect = recordA.intelect+recordB.intelect;
    sumRecord.defense = recordA.defense+recordB.defense;
    
    return sumRecord;
}

@end
