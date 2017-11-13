//
//  heroDatabase.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "heroDatabase.h"

@implementation heroDatabase

-(heroRecord*) getHeroByIndex:(int)index
{
    heroRecord *newRecord = [[heroRecord alloc]init];
    
    
    newRecord.strength = 3;
    newRecord.agility =2;
    newRecord.intelect = 3;
    newRecord.defense = 1;
    
    return newRecord;

}

@end
