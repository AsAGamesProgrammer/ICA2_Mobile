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

-(orcRecord*) getNextOrc
{
    srand(time(NULL));

    //DEFAULT RECORD------------------------------------
    orcRecord *newRecord = [[orcRecord alloc]init];
    
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
            newRecord.strength=rand() % 70 + 30;
            break;
            
        case 1:
            newRecord.intelect=rand() % 70 + 30;
            break;
            
        case 2:
            newRecord.agility=rand() % 70 + 30;
            break;
            
        case 3:
            newRecord.defense=rand() % 70 + 30;
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
            newRecord.deathImg=@"OrcDead";
            break;
            
        case 1:
            newRecord.imageName=@"Orc2.png";
            newRecord.deathImg=@"Orc2Dead";
            break;
            
        case 2:
            newRecord.imageName=@"Orc3.png";
            newRecord.deathImg=@"Orc3Dead";
            break;
            
        default:
            newRecord.imageName=@"Orc.png";
            newRecord.deathImg=@"OrcDead";
            break;
    }
    
    
    return newRecord;
}

@end
