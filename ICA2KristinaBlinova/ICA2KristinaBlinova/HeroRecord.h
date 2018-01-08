//
//  HeroRecord.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 08/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//


//--------------------------------------------------------------------
//                          OVERVIEW
// Represents an itance of a hero or weapon
// Inherits from the General record
//--------------------------------------------------------------------

#import "GeneralRecord.h"

@interface HeroRecord : GeneralRecord

//Has a name
@property (nonatomic) NSString* name;

@end
