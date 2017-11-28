//
//  VCLobby.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "heroRecord.h"

@interface VCLobby : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int currentHeroID;
@property (nonatomic) heroRecord* passedHeroRecord;

-(void)enablePlaceMode:(BOOL)toEnable;

//Called when an orc is defeated
-(void)orcDefeated;

@end
