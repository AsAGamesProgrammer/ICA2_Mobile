//
//  orcGenerator.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "orcGenerator.h"
#include <time.h>
#include <stdlib.h>

@implementation orcGenerator

-(heroRecord*) getNextOrc
{
    srand(time(NULL));
    int randomStat = rand() %4;
    
    
    heroRecord *newRecord = [[heroRecord alloc]init];
    
    newRecord.indx = 1;
    newRecord.strength=0;
    newRecord.intelect= 0;
    newRecord.agility=0;
    newRecord.defense=0;
    newRecord.imageName = @"Orc.png";
    
    switch(randomStat)
    {
        case 0:
            newRecord.strength=rand() % 50;
            break;
            
        case 1:
            newRecord.intelect=rand() % 50;
            break;
            
        case 2:
            newRecord.agility=rand() % 50;
            break;
            
        case 3:
            newRecord.defense=rand() % 50;
            break;
    }
    
    return newRecord;
}

@end
