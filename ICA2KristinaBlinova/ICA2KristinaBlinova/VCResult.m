//
//  VCResult.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCResult.h"
#import "heroDatabase.h"
#import "VCLobby.h"

@interface VCResult ()

@property (weak, nonatomic) IBOutlet UILabel *strLbl;
@property (weak, nonatomic) IBOutlet UILabel *agilLbl;
@property (weak, nonatomic) IBOutlet UILabel *intlLbl;
@property (weak, nonatomic) IBOutlet UILabel *defLbl;
@property (weak, nonatomic) IBOutlet UILabel *indxLbl;

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
    _indxLbl.text = [@(self.index) stringValue];
    
    
}

- (IBAction)keppPrssed:(UIButton *)sender
{
    VCLobby* keepViewController = (VCLobby*)(self.navigationController.viewControllers[1]);
    keepViewController.currentHeroID=self.index;
    

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToViewController:keepViewController animated:YES];
    //[self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"keepSegue"])
//    {
//        VCLobby *keepViewController = [segue destinationViewController];
//        //resultViewController.strengthValue = @"5";
//        keepViewController.currentHeroID= self.index;
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
