//
//  GeneralRecord.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//---------------------------------------------------------------------------
//                  OVERVIEW
// This class is a base class  used to store both Orc and Character records
// as parameters are identical.
//---------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface GeneralRecord : NSObject

//Id of a hero or weapon
@property (nonatomic) int indx;

//Stats
@property (nonatomic) NSInteger strength;
@property (nonatomic) NSInteger agility;
@property (nonatomic) NSInteger intelect;
@property (nonatomic) NSInteger defense;

//Image name
@property (nonatomic, strong) NSString* imageName;

@end
