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
        toImage.image = [UIImage imageNamed:_passedHeroRecord.imageName];
        _ownedHeroes[atIndex]=_passedHeroRecord;
    }
    //Reset index
    self.currentHeroID=-1;
}


//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    heroRecord* emptyRecord = [[heroRecord alloc] init];
    _ownedHeroes = [NSMutableArray arrayWithObjects:emptyRecord, emptyRecord, emptyRecord, nil];
   
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

        fightViewController.heroes= _ownedHeroes;
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
