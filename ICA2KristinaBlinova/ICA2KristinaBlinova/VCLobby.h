//
//  VCLobby.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralRecord.h"
#import "enumCodeType.h"
#import "HeroRecord.h"

@interface VCLobby : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int currentHeroID;
@property (nonatomic) GeneralRecord* passedHeroRecord;
@property (nonatomic) NSString* passedName;

@property (nonatomic) HeroRecord* passedHero;
-(void) heroPassed;
-(void) weaponPassed;

//Called when an orc is defeated
-(void)orcDefeated;

@end
