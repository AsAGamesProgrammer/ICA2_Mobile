//
//  VCLobby.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//
//
//---------------------------------------------------------------


#import <AVFoundation/AVFoundation.h>

#import "VCLobby.h"
#import "VCFight.h"
#import "orcGenerator.h"
#import "Utilities.h"
#import "audioManager.h"

@interface VCLobby ()

//Hero Images
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;

//Weapons
@property (weak, nonatomic) IBOutlet UIImageView *firstWeapon;
@property (weak, nonatomic) IBOutlet UIImageView *secondWeapon;
@property (weak, nonatomic) IBOutlet UIImageView *thirdWeapon;

//Hero gradient stripes
@property (weak, nonatomic) IBOutlet UIImageView *firstStripe;
@property (weak, nonatomic) IBOutlet UIImageView *secondStripe;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStripe;

//Buttons for palcing heroes/weapons
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

//Records of all the owned heroes
@property (nonatomic) NSMutableArray *ownedHeroes;
@property (nonatomic) NSMutableArray *ownedWeapons;

//Button which opens fighting view controller
@property (weak, nonatomic) IBOutlet UIButton *fightBtn;

//Stat labels
@property (weak, nonatomic) IBOutlet UILabel *firstStatLbl;
@property (weak, nonatomic) IBOutlet UILabel *secondStatLbl;
@property (weak, nonatomic) IBOutlet UILabel *thirdStatLbl;

//Orcs
@property (strong, nonatomic) orcRecord* orcRecord;

//Statistics
@property (weak, nonatomic) IBOutlet UILabel *defeatedOrcLbl;
@property (nonatomic) NSInteger defeatedOrcNumber;

//Type passed - weapon or hero
@property (nonatomic) RecordTypes typePassed;

//Name labels
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *secondName;
@property (weak, nonatomic) IBOutlet UILabel *thirdName;

//Banner label
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

//Utilities
@property (nonatomic) Utilities* utilityManager;

//Audio player
@property (nonatomic) audioManager *audioPlayer;

@end

@implementation VCLobby

//VARIABLES
//NSArray* tableData;
//NSArray* icons;

NSMutableArray* statusLabels;
NSMutableArray* nameLabels;

//--------------------------------------------------------
//                     BUTTON CLICKS
//--------------------------------------------------------
- (IBAction)selectFirst:(UIButton *)sender
{
    if(_typePassed == Hero)
    {
        _firstStripe.hidden=NO;
        [self setNewHero:_firstImg atArray:0];
    }
    
    if(_typePassed == Weapon)
    {
        [self setNewWeapon:_firstWeapon atArray:0];
    }
    
}

- (IBAction)selectSecond:(UIButton *)sender
{
    if(_typePassed == Hero)
    {
        _secondStripe.hidden=NO;
        [self setNewHero:_secondImg atArray:1];
    }
    
    if(_typePassed == Weapon)
    {
        [self setNewWeapon:_secondWeapon atArray:1];
    }
}

- (IBAction)selectThird:(UIButton *)sender
{
    if(_typePassed == Hero)
    {
        _thirdStripe.hidden=NO;
        [self setNewHero:_thirdImg atArray:2];
    }
    
    if(_typePassed == Weapon)
    {
        [self setNewWeapon:_thirdWeapon atArray:2];
    }
}

//--------------------------------------------------------
//                  PUBLIC FUNCTIONALITY
//--------------------------------------------------------
//Recived a hero from the result view
-(void) heroPassed
{
    _typePassed=Hero;
    [self enablePlaceMode:YES];
    
    //Label
    _headerLabel.text=NSLocalizedString(@"PlaceHero", nil);
}

//Receive a weapon fromt the result view controller
-(void) weaponPassed
{
    _typePassed = Weapon;
    [self enablePlaceMode:YES];
    
    //Check if weapon can be placed
    HeroRecord* heroR = _ownedHeroes[0];
    if(heroR.imageName==nil)
    {
        _firstBtn.enabled=NO;
        _firstBtn.alpha = 0.5;
    }
    
    heroR = _ownedHeroes[1];
    if(heroR.imageName==nil)
    {
        _secondBtn.enabled=NO;
        _secondBtn.alpha=0.5;
    }
    
    heroR = _ownedHeroes[2];
    if(heroR.imageName==nil)
    {
        _thirdBtn.enabled=NO;
        _thirdBtn.alpha=0.5;
    }
    
    //Label
    _headerLabel.text=NSLocalizedString(@"PlaceWeapon", nil);
    
}

//Defeated an orc msg from the fighting view controller
-(void) orcDefeated
{
    _defeatedOrcNumber++;
    _defeatedOrcLbl.text = [@(_defeatedOrcNumber) stringValue];
    
    orcGenerator* orcGeneration = [[orcGenerator alloc] init];
    _orcRecord = [orcGeneration getNextOrc];
    
     self.navigationController.navigationBar.hidden = YES;
}

//--------------------------------------------------------
//                  SET NEW FUNCTIONALITY
//--------------------------------------------------------
//HEROES
-(void) setNewHero:(UIImageView*)toImage atArray:(int)atIndex
{
    if(_currentHeroID >0)
    {
        //Set image of a chosen slot
        toImage.image = [UIImage imageNamed:_passedHero.imageName];
        
        //Add a hero to a array of owned heroes
        _ownedHeroes[atIndex]=_passedHero;
        
        //Set UI to not placing hero sate
        [self enablePlaceMode:NO];
        
        //Allow fighting
        _fightBtn.enabled=true;
        _fightBtn.alpha=1.0;
        
        //Set status labels
        UILabel* statLabel = statusLabels[atIndex];
        statLabel.text = [self getStatusLabel:atIndex];
        
        //Set name label
        UILabel* nameLabel = nameLabels[atIndex];
        nameLabel.text = _passedHero.name;
    }
    //Reset index
    self.currentHeroID=-1;
    
    //Header
    _headerLabel.text=NSLocalizedString(@"ReadyToFight", nil);
    
    //Audio
    [_audioPlayer playPlaceHeroAudio];
}

//WEAPONS
-(void) setNewWeapon:(UIImageView*)toImage atArray:(int)atIndex
{
    if(_currentHeroID >0)
    {
        //Set image of a chosen slot
        toImage.image = [UIImage imageNamed:_passedHero.imageName];
        
        //Add a weapon to a array of owned weapons
        _ownedWeapons[atIndex]=_passedHero;
        
        //Set UI to not placing hero sate
        [self enablePlaceMode:NO];
        
        //Set status labels
        UILabel* statLabel = statusLabels[atIndex];
        statLabel.text = [self getStatusLabel:atIndex];
        
       //Audio
        [_audioPlayer playPlaceWeaponAudio];
        
    }
    //Reset index
    self.currentHeroID=-1;
}

//Update stats
-(NSString*) getStatusLabel:(int)atIndex
{
    GeneralRecord* heroR = _ownedHeroes[atIndex];
    GeneralRecord* weaponR = _ownedWeapons[atIndex];
    
    //Combine hero and weapon record
    GeneralRecord* combinedRecord = [_utilityManager sumGeneralRecordA:heroR andGeneralRecordB:weaponR];
    
    //Update a status label
    NSString* strValue =[@(combinedRecord.strength) stringValue];
    NSString* aglValue =[@(combinedRecord.agility) stringValue];
    NSString* intlValue =[@(combinedRecord.intelect) stringValue];
    NSString* defValue =[@(combinedRecord.defense) stringValue];
    
    NSString* localisationString = NSLocalizedString(@"Stats", nil);
    NSString* statString = [NSString stringWithFormat:localisationString, strValue, aglValue, intlValue, defValue];
    
    return statString;
}
//--------------------------------------------------------
//                     INTERFACE
//--------------------------------------------------------

//Enabeles/Disables "place here" buttons
-(void) enablePlaceMode:(BOOL)toEnable
{
    _firstBtn.hidden=!toEnable;
    _secondBtn.hidden=!toEnable;
    _thirdBtn.hidden=!toEnable;
    
    _firstBtn.enabled=YES;
    _secondBtn.enabled=YES;
    _thirdBtn.enabled=YES;
    
    _firstBtn.alpha=1.0;
    _secondBtn.alpha=1.0;
    _thirdBtn.alpha=1.0;
    
    self.navigationController.navigationBar.hidden = YES;
}


//--------------------------------------------------------
//                     VIEW RELATED
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize a hero record array with empty records
    HeroRecord* emptyHRecord = [[HeroRecord alloc] init];
    _ownedHeroes = [NSMutableArray arrayWithObjects:emptyHRecord, emptyHRecord, emptyHRecord, nil];
    _ownedWeapons = [NSMutableArray arrayWithObjects:emptyHRecord, emptyHRecord, emptyHRecord, nil];
    
    //Disable fighting as no heroes exist
    _fightBtn.enabled=NO;
    _fightBtn.alpha=0.5;
    
    //Set label to no placing heroes
    [self enablePlaceMode:NO];
    
    //Status label array
    statusLabels = [NSMutableArray arrayWithObjects:_firstStatLbl, _secondStatLbl, _thirdStatLbl, nil];
    nameLabels = [NSMutableArray arrayWithObjects:_firstName, _secondName, _thirdName, nil];
    
    //Orc
    //Create an orc generator
    orcGenerator* orcGeneration = [[orcGenerator alloc] init];
    _orcRecord = [orcGeneration getNextOrc];
    
    //Statistics
    _defeatedOrcNumber = 0;
    _defeatedOrcLbl.text = [@(_defeatedOrcNumber) stringValue];
    
    //Navigation bar
     self.navigationController.navigationBar.hidden = YES;
    
    _headerLabel.text = NSLocalizedString(@"LetsScan", nil);
    
    _utilityManager = [[Utilities alloc] init];
    
    //Audio
    _audioPlayer = [[audioManager alloc] init];
    [_audioPlayer initializePlayer];
    
    
}

//WARNING
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//PREPARE FOR SEGUE
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Play a click sound
    [_audioPlayer playClick];
    
    //If moving to a fighting iew controller
    if([segue.identifier isEqualToString:@"fightSegue"])
    {
        VCFight *fightViewController = [segue destinationViewController];

        //Create an array of existing heroes to avoid passing NO HERO slots
        NSMutableArray* existingHeroes = [[NSMutableArray alloc] init];
        
        //Go throug hero records
        for(int i=0; i<3; i++)
        {
            HeroRecord* heroR = _ownedHeroes[i];
            if(!(heroR.imageName == nil))
            {
                //Find a matching weapon record
                HeroRecord* weaponR = _ownedWeapons[i];
                if(weaponR.imageName!=nil)
                {
                    //Sum up two records to create a new one
                    HeroRecord* sumRecord = [_utilityManager sumRecordA:heroR andRecordB:weaponR];
                    sumRecord.imageName=heroR.imageName;
                    sumRecord.name = heroR.name;
                    
                    [existingHeroes addObject:sumRecord];
                    
                }
                else
                {
                   [existingHeroes addObject:heroR];
                }
                
            }
        }
        
        //If heroes exist
        if(existingHeroes.count>0)
            fightViewController.heroes= existingHeroes;
        
        //Pass an orc
        fightViewController.currentOrcRecord = _orcRecord;
        
        //Battle Number
        fightViewController.battleNumber = _defeatedOrcNumber + 1;
        
    }
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
