//
//  weaponDatabase.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 04/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "weaponDatabase.h"

@implementation weaponDatabase

NSArray *arrayWeapons;

//Create all heroes
-(void) createHeroes
{
    
    arrayWeapons = @[[self createAHero:0 :0 :0 :0 :@"NoHero.png"],
                     [self createAHero:0 :0 :0 :20 :@"AShield.png"],
                     [self createAHero:30 :0 :0 :0 :@"WAxe.png"],
                     [self createAHero:25 :0 :5 :0 :@"DSword.png"],
                     [self createAHero:0 :0 :0 :25 :@"KShield.png"],
                     [self createAHero:10 :10 :0 :0 :@"KSword.png"],
                     [self createAHero:20 :0 :0 :10 :@"ASword.png"],
                     [self createAHero:0 :40 :0 :0 :@"bow.png"]];
}



//Create one hero
-(heroRecord*) createAHero
:(NSInteger)str
:(NSInteger)agl
:(NSInteger)intl
:(NSInteger)def
:(NSString*)imgName
{
    heroRecord *newRecord = [[heroRecord alloc]init];
    newRecord.strength = str;
    newRecord.agility =agl;
    newRecord.intelect = intl;
    newRecord.defense = def;
    newRecord.imageName = imgName;
    return newRecord;
    
}

-(heroRecord*) getWeaponByIndex:(int)index
{
    [self createHeroes];
    
    return arrayWeapons[index];
}

@end
