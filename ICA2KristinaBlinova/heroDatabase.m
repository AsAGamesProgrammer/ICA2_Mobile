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

//Create all heroes
-(void) createHeroes
{
    
    array = @[[self createAHero:0 :0 :0 :0 :@"NoHero.png"],
              [self createAHero:0 :0 :0 :100 :@"Amazon.png"],
              [self createAHero:100 :0 :0 :0 :@"Fighter.png"],
              [self createAHero:0 :100 :0 :0 :@"Archer.png"],
              [self createAHero:0 :0 :25 :75 :@"Amazon2.png"],
              [self createAHero:70 :30 :0 :0 :@"Archer2.png"],
              [self createAHero:30 :70 :0 :0 :@"Knight2.png"],
              [self createAHero:0 :0 :100 :0 :@"Knight.png"]];
}



//Create one hero
-(GeneralRecord*) createAHero
                          :(NSInteger)str
                          :(NSInteger)agl
                          :(NSInteger)intl
                          :(NSInteger)def
                          :(NSString*)imgName
{
    GeneralRecord *newRecord = [[GeneralRecord alloc]init];
    newRecord.strength = str;
    newRecord.agility =agl;
    newRecord.intelect = intl;
    newRecord.defense = def;
    newRecord.imageName = imgName;
    return newRecord;

}

//Return a hero by index
//TODO: try creating heroes differently e.g. database, not on every call
-(GeneralRecord*) getHeroByIndex:(int)index
{
    [self createHeroes];

    return array[index];
}

@end
