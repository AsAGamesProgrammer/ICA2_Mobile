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

    //DEFAULT RECORD------------------------------------
    heroRecord *newRecord = [[heroRecord alloc]init];
    
    newRecord.indx = 1;
    newRecord.strength=0;
    newRecord.intelect= 0;
    newRecord.agility=0;
    newRecord.defense=0;

    //RANDOM STAT---------------------------------------
    int randomStat = rand() %4;
    
    switch(randomStat)
    {
        case 0:
            newRecord.strength=rand() % 50 + 10;
            break;
            
        case 1:
            newRecord.intelect=rand() % 50 + 10;
            break;
            
        case 2:
            newRecord.agility=rand() % 50 + 10;
            break;
            
        case 3:
            newRecord.defense=rand() % 50 + 10;
            break;
            
        default:
            break;
    }
    
    //RANDOM IMAGE---------------------------------------
    int randomImg = rand()%3;
    
    switch(randomImg)
    {
        case 0:
            newRecord.imageName=@"Orc.png";
            break;
            
        case 1:
            newRecord.imageName=@"Orc2.png";
            break;
            
        case 2:
            newRecord.imageName=@"Orc3.png";
            break;
            
        default:
            newRecord.imageName=@"Orc.png";
            break;
    }
    
    
    return newRecord;
}

@end