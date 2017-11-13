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

@property (nonatomic, strong) IBOutlet UILabel *strLbl;

@end

@implementation VCResult

@synthesize strengthValue;
@synthesize strLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    heroDatabase* heroDB = [[heroDatabase alloc] init];
    heroRecord *heroR = [heroDB getHeroByIndex:0];
    
    strLbl.text = [@(heroR.strength) stringValue];
    //strLbl.text = [@(heroR.agility) stringValue];
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
