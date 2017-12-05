//
//  VCResult.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "enumCodeType.h"

@interface VCResult : UIViewController

@property (nonatomic, strong) NSString *strengthValue;
@property (nonatomic) int index;
@property (nonatomic) RecordTypes type;
@property (nonatomic) NSString* codeName;

@end
