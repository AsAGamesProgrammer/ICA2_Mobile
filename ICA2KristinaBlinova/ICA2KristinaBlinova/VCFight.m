//
//  VCFight.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCFight.h"
#import "FightViewCell.h"
#import "QuartzCore/QuartzCore.h"
#import "VCLobby.h"

@interface VCFight ()

@property (weak, nonatomic) IBOutlet UIImageView *heroImg;
@property (nonatomic) int currentHeroNumber;
@property (nonatomic) int totalHeroNumber;

//Connection to a table
@property (weak, nonatomic) IBOutlet UITableView *statTable;

//Pop up wth the fight result
@property (weak, nonatomic) IBOutlet UIView *victoryView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;

@property (nonatomic) BOOL orcDead;
@property (weak, nonatomic) IBOutlet UIImageView *orcImg;
@property (weak, nonatomic) IBOutlet UILabel *battleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;

@end

@implementation VCFight

//------------------TABLE--------------------
//VARIABLES
NSArray* tableHeroData;
NSArray* tableOrcData;
NSArray* icons;

//Number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [icons count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

//Each row display
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FightingTableCell";
    
    FightViewCell *cell = (FightViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FightingTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    //Hero stats
    cell.heroValueLbl.text = [tableHeroData objectAtIndex:indexPath.row];
    
    //Orc stats
    cell.orcValueLbl.text = [tableOrcData objectAtIndex:indexPath.row];
    
    //Choose a picture
    cell.iconImg.image = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
    
    return cell;
}

//------------------GESTURES-----------------
//Swipe right
- (IBAction)swipeHeroRight:(UISwipeGestureRecognizer *)sender
{
    //Load next hero
    if(_currentHeroNumber + 1 <_totalHeroNumber)
    {
        _currentHeroNumber++;
    }
    else
    {
        _currentHeroNumber=0;
    }
    
    [self changeHeroOnSwipe];
}

//Swipe left
- (IBAction)swipeHeroLeft:(UISwipeGestureRecognizer *)sender
{
    //Load next hero
    if(_currentHeroNumber >0)
    {
        _currentHeroNumber--;
    }
    else
    {
        _currentHeroNumber=_totalHeroNumber-1;
    }
    
    [self changeHeroOnSwipe];
}

-(void) changeHeroOnSwipe
{
    GeneralRecord* record = _heroes[_currentHeroNumber];
    
    //Update hero image
    _heroImg.image = [UIImage imageNamed:record.imageName];
    
    //Update table data
    tableHeroData = [NSArray arrayWithObjects: [@(record.strength) stringValue],
                     [@(record.agility) stringValue],
                     [@(record.intelect) stringValue],
                     [@(record.defense) stringValue], nil];
    
    _heroNameLabel.text = _heroNames[_currentHeroNumber];
    
    [self.statTable reloadData];
}

//------------------BUTTONS------------------
//Retreat
- (IBAction)retreatClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Fight
- (IBAction)fightClick:(id)sender
{
    //Compare hero stats to the orc
    GeneralRecord* heroRec = _heroes[_currentHeroNumber];
    
    if(heroRec.strength>=_currentOrcRecord.strength &&
       heroRec.intelect>=_currentOrcRecord.intelect &&
       heroRec.agility>=_currentOrcRecord.agility &&
       heroRec.defense>=_currentOrcRecord.defense)
    {
        //VICTORY
        //Change label text
        _resultLabel.text=@"Victory";
        
        //Change label/button colours
        self.resultLabel.textColor = [UIColor colorWithRed:(0/255.f) green:(128/255.f) blue:(0/255.f) alpha:1];
        self.resultBtn.backgroundColor = [UIColor colorWithRed:(0/255.f) green:(128/255.f) blue:(0/255.f) alpha:1];
        
        //Confirm victory
        _orcDead=YES;
    }
    else
    {
        //DEFEAT
        //Change label text
        _resultLabel.text=@"Defeat";
        
        //Change label/button colours
        self.resultLabel.textColor = [UIColor colorWithRed:(134/255.f) green:(13/255.f) blue:(13/255.f) alpha:1];
        self.resultBtn.backgroundColor = [UIColor colorWithRed:(134/255.f) green:(13/255.f) blue:(13/255.f) alpha:1];
    }
    
    //Show a result view
    _victoryView.hidden=false;
}

//Result button click
- (IBAction)resultClick:(UIButton *)sender
{
    VCLobby* lobbyViewController = (VCLobby*)(self.navigationController.viewControllers[1]);
    
    if(_orcDead)
        [lobbyViewController orcDefeated];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToViewController:lobbyViewController animated:YES];
}


//-----------------VIEW CNTROLS--------------
//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set initial hero picture
    GeneralRecord* firstRecord = _heroes[0];
    _heroImg.image = [UIImage imageNamed:firstRecord.imageName];
    _heroNameLabel.text = _heroNames[0];
    
    //Enable interactions on hero image
    _heroImg.userInteractionEnabled = YES;
    
    //Current hero img
    _currentHeroNumber=0;
    
    //Set total number of available heroes to the number of paed records
    _totalHeroNumber = (int)_heroes.count;
    
    //TABLE
    //Set initial hero stats to a table
    tableHeroData = [NSArray arrayWithObjects: [@(firstRecord.strength) stringValue],
                                               [@(firstRecord.agility) stringValue],
                                               [@(firstRecord.intelect) stringValue],
                                               [@(firstRecord.defense) stringValue], nil];
    
    //Set orc stats to a table
    tableOrcData = [NSArray arrayWithObjects: [@(_currentOrcRecord.strength) stringValue],
                                              [@(_currentOrcRecord.agility) stringValue],
                                              [@(_currentOrcRecord.intelect) stringValue],
                                              [@(_currentOrcRecord.defense) stringValue], nil];
    
    //Orc image
    _orcImg.image = [UIImage imageNamed:_currentOrcRecord.imageName];
    
    icons = [NSArray arrayWithObjects:@"sword.png", @"featherA.png", @"bookI.png", @"beltD.png", nil];
    
   // _statTable.layer.borderWidth=2.0;
    //_statTable.layer.borderColor=[UIColor yellowColor].CGColor;
    
    //Victory/Defeat
    _victoryView.hidden=true;
    _orcDead = NO;
    
     self.navigationController.navigationBar.hidden = NO;
    
    //Banner
    _battleNumberLabel.text = [@(_battleNumber) stringValue];
    
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
