//
//  VCResult.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 13/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//
//-----------------------------------------------------------------
//TODO: Pretty share button
//Share picture + stats

#import "VCResult.h"
#import "heroDatabase.h"
#import "weaponDatabase.h"
#import "VCLobby.h"
#import "HeroRecord.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface VCResult ()

@property (weak, nonatomic) IBOutlet UILabel *strLbl;
@property (weak, nonatomic) IBOutlet UILabel *agilLbl;
@property (weak, nonatomic) IBOutlet UILabel *intlLbl;
@property (weak, nonatomic) IBOutlet UILabel *defLbl;
@property (weak, nonatomic) IBOutlet UILabel *indxLbl;
@property (weak, nonatomic) IBOutlet UIImageView *characterPreview;

@property (weak, nonatomic) GeneralRecord* heroR;

//Header label
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (weak, nonatomic) IBOutlet UILabel *heroName;

//Buttons
@property (weak, nonatomic) IBOutlet UIImageView *facebookLogo;

@end

@implementation VCResult

//----VIEW DID LOAD-------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_type == Hero)
    {
        //Create a database instance
        heroDatabase* heroDB = [[heroDatabase alloc] init];
        //Query a database for a hero record
        _heroR = [heroDB getHeroByIndex:self.index];
    }
    
    if(_type == Weapon)
    {
        weaponDatabase* weaponDB = [[weaponDatabase alloc] init];
        _heroR = [weaponDB getWeaponByIndex:self.index];
    }
    
    //Assign hero record data to labels
    _strLbl.text = [@(_heroR.strength) stringValue];
    _agilLbl.text = [@(_heroR.agility) stringValue];
    _intlLbl.text = [@(_heroR.intelect) stringValue];
    _defLbl.text = [@(_heroR.defense) stringValue];
    _indxLbl.text = [@(self.index) stringValue];
    _characterPreview.image = [UIImage imageNamed: _heroR.imageName];
    
    //Header label
    _headerLbl.text=_codeName;
    
    //Name generation
    if(_type == Hero)
        [self generateName];
    
    if(_type==Weapon)
        _heroName.text=NSLocalizedString(@"WeaponRemark", nil);
    
    //Interactions
    [_facebookLogo setUserInteractionEnabled:YES];
    
     self.navigationController.navigationBar.hidden = YES;
}



//------------------------------------------------------------------
//                            FACEBOOK
//------------------------------------------------------------------

- (IBAction)facebookClicked:(UITapGestureRecognizer *)sender
{
    //FACEBOOK
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = _characterPreview.image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    
    //Works
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}

//------------------------------------------------------------------
//                           NAME GENERATOR
//------------------------------------------------------------------
//This s done not on the main queue
-(void) generateName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlAsString = @"https://uinames.com/api/?region=india";
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlAsString]];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
        _heroName.text = [json objectForKey: @"name"];
        });
    });
}


//------------------------------------------------------------------
//                              BUTTONS
//------------------------------------------------------------------

//KEEP: Send update to the root and pop back to the lobby
- (IBAction)keppPrssed:(UIButton *)sender
{
    //Generate a full record
    HeroRecord* heroRecord = [[HeroRecord alloc] init];
    
    heroRecord.strength = _heroR.strength;
    heroRecord.agility = _heroR.agility;
    heroRecord.intelect = _heroR.intelect;
    heroRecord.defense = _heroR.defense;
    heroRecord.name = _heroName.text;
    heroRecord.imageName = _heroR.imageName;
    
    VCLobby* keepViewController = (VCLobby*)(self.navigationController.viewControllers[1]);
    keepViewController.currentHeroID=self.index;
    keepViewController.passedHero = heroRecord;
    
    //Awake a function in the lobby
    if(_type == Hero)
    {
        [keepViewController heroPassed];
    }
    
    if(_type == Weapon)
    {
        [keepViewController weaponPassed];
    }
    

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToViewController:keepViewController animated:YES];
}

//DISCARD: pop back to the lobby
- (IBAction)discardPressed:(UIButton *)sender
{
    VCLobby* keepViewController = (VCLobby*)(self.navigationController.viewControllers[1]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToViewController:keepViewController animated:YES];
}


//WARNING
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//SEGUE
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
