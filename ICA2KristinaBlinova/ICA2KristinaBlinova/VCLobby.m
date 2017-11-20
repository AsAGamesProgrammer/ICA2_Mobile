//
//  VCLobby.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCLobby.h"
#import "VCFight.h"


@interface VCLobby ()

@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;

@property (nonatomic) NSMutableArray *ownedHeroes;

@property (weak, nonatomic) IBOutlet UIButton *fightBtn;

@end

@implementation VCLobby

//BUTTON CLICKS
- (IBAction)selectFirst:(UIButton *)sender
{
    [self setNewHero:_firstImg atArray:0];
}

- (IBAction)selectSecond:(UIButton *)sender
{
    [self setNewHero:_secondImg atArray:1];
}

- (IBAction)selectThird:(UIButton *)sender
{
    [self setNewHero:_thirdImg atArray:2];
}

//FUNCTIONALITY
-(void) setNewHero:(UIImageView*)toImage atArray:(int)atIndex
{
    if(_currentHeroID >0)
    {
        //Set image of a chosen slot
        toImage.image = [UIImage imageNamed:_passedHeroRecord.imageName];
        
        //Add a hero to a array of owned heroes
        _ownedHeroes[atIndex]=_passedHeroRecord;
        
        //Enable fighting as more than one hero exists
        _fightBtn.enabled=YES;
    }
    //Reset index
    self.currentHeroID=-1;
}


//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    heroRecord* emptyRecord = [[heroRecord alloc] init];
    _ownedHeroes = [NSMutableArray arrayWithObjects:emptyRecord, emptyRecord, emptyRecord, nil];
   
    //Disable fighting as no heroes exist
    _fightBtn.enabled=NO;
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
