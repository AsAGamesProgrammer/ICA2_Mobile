//
//  weaponDatabase.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 04/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          OVERVIEW
// Collection of all the weapons.
// Further development: can be moved to SQLite or MySQL
//--------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "GeneralRecord.h"

@interface weaponDatabase : NSObject

-(GeneralRecord*) getWeaponByIndex:(int)index;

@end
