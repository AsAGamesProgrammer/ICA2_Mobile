//
//  VCLobby.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCLobby.h"
#import "VCFight.h"
#import "orcGenerator.h"

@interface VCLobby ()

//Hero Images
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;

//Hero gradient stripes
@property (weak, nonatomic) IBOutlet UIImageView *firstStripe;
@property (weak, nonatomic) IBOutlet UIImageView *secondStripe;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStripe;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

//Records of all the owned heroes
@property (nonatomic) NSMutableArray *ownedHeroes;

//Button which opens fighting view controller
@property (weak, nonatomic) IBOutlet UIButton *fightBtn;

//Label whch appears when u place your hero
@property (weak, nonatomic) IBOutlet UILabel *placeLbl;

//Stat labels
@property (weak, nonatomic) IBOutlet UILabel *firstStatLbl;
@property (weak, nonatomic) IBOutlet UILabel *secondStatLbl;
@property (weak, nonatomic) IBOutlet UILabel *thirdStatLbl;

//Orcs
@property (strong, nonatomic) heroRecord* orcRecord;

//Statistics
@property (weak, nonatomic) IBOutlet UILabel *defeatedOrcLbl;
@property (nonatomic) NSInteger defeatedOrcNumber;

@end

@implementation VCLobby

//VARIABLES
//NSArray* tableData;
//NSArray* icons;

NSMutableArray* statusLabels;

//--------------------------------------------------------
//                     BUTTON CLICKS
//--------------------------------------------------------
- (IBAction)selectFirst:(UIButton *)sender
{
    _firstStripe.hidden=NO;
    [self setNewHero:_firstImg atArray:0];
}

- (IBAction)selectSecond:(UIButton *)sender
{
    _secondStripe.hidden=NO;
    [self setNewHero:_secondImg atArray:1];
}

- (IBAction)selectThird:(UIButton *)sender
{
    _thirdStripe.hidden=NO;
    [self setNewHero:_thirdImg atArray:2];
}

//--------------------------------------------------------
//                  PUBLIC FUNCTIONALITY
//--------------------------------------------------------
-(void) enablePlaceMode:(BOOL)toEnable
{
    _placeLbl.hidden=!toEnable;
    _firstBtn.hidden=!toEnable;
    _secondBtn.hidden=!toEnable;
    _thirdBtn.hidden=!toEnable;
}

-(void) orcDefeated
{
    _defeatedOrcNumber++;
    _defeatedOrcLbl.text = [@(_defeatedOrcNumber) stringValue];
    
    orcGenerator* orcGeneration = [[orcGenerator alloc] init];
    _orcRecord = [orcGeneration getNextOrc];
}

//--------------------------------------------------------
//                  PRIVATE FUNCTIONALITY
//--------------------------------------------------------
-(void) setNewHero:(UIImageView*)toImage atArray:(int)atIndex
{
    if(_currentHeroID >0)
    {
        //Set image of a chosen slot
        toImage.image = [UIImage imageNamed:_passedHeroRecord.imageName];
        
        //Add a hero to a array of owned heroes
        _ownedHeroes[atIndex]=_passedHeroRecord;
        
        //Set UI to not placing hero sate
        [self enablePlaceMode:NO];
        
        //Allow fighting
        _fightBtn.enabled=true;
        
        //Set status labels
        UILabel* statLabel = statusLabels[atIndex];
        statLabel.text = [self getStatusLabel];
        
    }
    //Reset index
    self.currentHeroID=-1;
}

-(NSString*) getStatusLabel
{
    //Values from the record
    NSString* strValue =[@(_passedHeroRecord.strength) stringValue];
    NSString* aglValue =[@(_passedHeroRecord.agility) stringValue];
    NSString* intlValue =[@(_passedHeroRecord.intelect) stringValue];
    NSString* defValue =[@(_passedHeroRecord.defense) stringValue];
    NSString* statString = [NSString stringWithFormat:@"(Str)%@, (Agl)%@, (Inl)%@, (Def)%@", strValue, aglValue, intlValue, defValue];
    
    return statString;
}

//--------------------------------------------------------
//                     VIEW RELATED
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize a hero record array with empty records
    heroRecord* emptyRecord = [[heroRecord alloc] init];
    _ownedHeroes = [NSMutableArray arrayWithObjects:emptyRecord, emptyRecord, emptyRecord, nil];
   
    //Disable fighting as no heroes exist
    _fightBtn.enabled=NO;
    
    //Set label to no placing heroes
    [self enablePlaceMode:NO];
    
    //Status label array
    statusLabels = [NSMutableArray arrayWithObjects:_firstStatLbl, _secondStatLbl, _thirdStatLbl, nil];
    
    //Orc
    //Create an orc generator
    orcGenerator* orcGeneration = [[orcGenerator alloc] init];
    _orcRecord = [orcGeneration getNextOrc];
    
    //Statistics
    _defeatedOrcNumber = 0;
    _defeatedOrcLbl.text = [@(_defeatedOrcNumber) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fightSegue"])
    {
        VCFight *fightViewController = [segue destinationViewController];

        //Create an array of existing heroes to avoid passing NO HERO slots
        NSMutableArray* existingHeroes = [[NSMutableArray alloc] init];
        
        for(heroRecord* currentRecord in _ownedHeroes)
        {
            if(!(currentRecord.imageName == nil))
                [existingHeroes addObject:currentRecord];
        }
        
        if(existingHeroes.count>0)
            fightViewController.heroes= existingHeroes;
        
        //Pass an orc
        fightViewController.currentOrcRecord = _orcRecord;
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
