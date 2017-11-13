//
//  heroDatabase.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "heroDatabase.h"

@implementation heroDatabase

NSArray *array;

-(void) createHeroes
{
    //Record 0
    heroRecord *newRecord = [[heroRecord alloc]init];
    newRecord.strength = 5;
    newRecord.agility =2;
    newRecord.intelect = 3;
    newRecord.defense = 1;
    
    //Record 1
    heroRecord *newRecord1 = [[heroRecord alloc]init];
    newRecord1.strength = 50;
    newRecord1.agility =20;
    newRecord1.intelect = 30;
    newRecord1.defense = 10;
    
    //Record 2
    heroRecord *newRecord2 = [[heroRecord alloc]init];
    newRecord2.strength = 500;
    newRecord2.agility =200;
    newRecord2.intelect = 300;
    newRecord2.defense = 100;
    
    array = @[newRecord, newRecord1, newRecord2];
}

-(heroRecord*) getHeroByIndex:(int)index
{
    [self createHeroes];

    return array[index];
}

@end
