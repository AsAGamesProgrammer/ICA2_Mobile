//
//  VCResult.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          OVERVIEW
// Result view controller which appears after a succesful scan
//--------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "enumCodeType.h"

@interface VCResult : UIViewController

//ndex of a hero or weapon
@property (nonatomic) int index;

//Type of the record
@property (nonatomic) RecordTypes type;

//Name of the scanned code (such as qr or barcode)
@property (nonatomic) NSString* codeName;

@end
