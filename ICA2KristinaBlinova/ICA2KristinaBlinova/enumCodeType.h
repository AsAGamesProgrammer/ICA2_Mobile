//
//  enumCodeType.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 04/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          OVERVIEW
// This clas is used to differentiate between weapon and hero records
//--------------------------------------------------------------------


#import <Foundation/Foundation.h>

@interface enumCodeType : NSObject

typedef enum pasedRecordTypes
{
    Hero,
    Weapon
} RecordTypes;

@end
