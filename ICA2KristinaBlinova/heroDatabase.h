//
//  heroDatabase.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralRecord.h"

@interface heroDatabase : NSObject

-(GeneralRecord*) getHeroByIndex:(int)index;

@end
