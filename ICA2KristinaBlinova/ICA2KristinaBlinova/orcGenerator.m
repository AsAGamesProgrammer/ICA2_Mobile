//
//  orcGenerator.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "orcGenerator.h"

@implementation orcGenerator

-(heroRecord*) getNextOrc
{
    heroRecord *newRecord = [[heroRecord alloc]init];
    
    newRecord.indx = 1;
    newRecord.strength=0;
    newRecord.intelect=30;
    newRecord.agility=0;
    newRecord.defense=0;
    newRecord.imageName = @"Orc.png";
    
    return newRecord;
}

@end
