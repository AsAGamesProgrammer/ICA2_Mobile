//
//  heroDatabase.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          OVERVIEW
// Collection of all the heroes.
// Further development: can be moved to SQLite or MySQL
//--------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "GeneralRecord.h"

@interface heroDatabase : NSObject

-(GeneralRecord*) getHeroByIndex:(int)index;

@end
