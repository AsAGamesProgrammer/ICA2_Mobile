//
//  heroRecord.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface heroRecord : NSObject

@property (nonatomic) int indx;
@property (nonatomic) NSInteger strength;
@property (nonatomic) NSInteger agility;
@property (nonatomic) NSInteger intelect;
@property (nonatomic) NSInteger defense;
@property (nonatomic, strong) NSString* imageName;

@end
