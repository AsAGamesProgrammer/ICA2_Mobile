//
//  orcGenerator.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 28/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//------------------------------------------------------------------------
//                          OVERVIEW
// This clas sgenerates the next orc which player has to face
// RULES: 1) orc has 1 out of 3 posible sprites
//        2) when defeated a matching "dead" sprite is shown
//        3) orc only has one out of 4 stats with a vlue not equal to 0
//           this is done for easier testing and requires minimal balancing.
// Pont 3) can b improved in later builds
//------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "orcRecord.h"

@interface orcGenerator : NSObject

//generate a new random orc
-(orcRecord*) getNextOrc;

@end
