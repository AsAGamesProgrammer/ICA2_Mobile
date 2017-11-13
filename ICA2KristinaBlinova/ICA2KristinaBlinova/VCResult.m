//
//  VCResult.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCResult.h"
#import "heroDatabase.h"

@interface VCResult ()

@property (weak, nonatomic) IBOutlet UILabel *strLbl;
@property (weak, nonatomic) IBOutlet UILabel *agilLbl;
@property (weak, nonatomic) IBOutlet UILabel *intlLbl;
@property (weak, nonatomic) IBOutlet UILabel *defLbl;

@end

@implementation VCResult

//----VIEW DID LOAD-------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create a database instance
    heroDatabase* heroDB = [[heroDatabase alloc] init];
    //Query a database for a hero record
    heroRecord *heroR = [heroDB getHeroByIndex:self.index];
    
    //Assign hero record data to labels
    _strLbl.text = [@(heroR.strength) stringValue];
    _agilLbl.text = [@(heroR.agility) stringValue];
    _intlLbl.text = [@(heroR.intelect) stringValue];
    _defLbl.text = [@(heroR.defense) stringValue];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
