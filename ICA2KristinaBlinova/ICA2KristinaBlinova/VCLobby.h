//
//  VCLobby.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//


//--------------------------------------------------------------------
//                          OVERVIEW
// View controller for a lobby
//--------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "enumCodeType.h"
#import "HeroRecord.h"

@interface VCLobby : UIViewController <UITableViewDelegate, UITableViewDataSource>

//Variables
@property (nonatomic) int currentHeroID;        //Id of a hero passed from the result window
@property (nonatomic) HeroRecord* passedHero;   //Hero passed from the result window

//Funtions
-(void) heroPassed;
-(void) weaponPassed;

//Called when an orc is defeated
-(void)orcDefeated;

@end
