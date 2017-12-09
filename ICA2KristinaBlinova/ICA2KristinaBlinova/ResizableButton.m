//
//  ResizableButton.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//
//---------------------------------------------------------
// This class is created due to the localisation issues
// Sometimes a button has to be resized depending on the label
// which is what this class does
//

#import "ResizableButton.h"

@implementation ResizableButton

-(CGSize)intrinsicContentSize {
    return CGSizeMake(self.frame.size.width, self.titleLabel.frame.size.height);
}

@end
