//
//  VCFight.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCFight.h"
#import "heroRecord.h"
#import "FightViewCell.h"
#import  "QuartzCore/QuartzCore.h"

@interface VCFight ()

@property (weak, nonatomic) IBOutlet UIImageView *heroImg;
@property (nonatomic) int currentHeroNumber;
@property (nonatomic) int totalHeroNumber;

//Connection to a table
@property (weak, nonatomic) IBOutlet UITableView *statTable;

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
    heroRecord* record = _heroes[_currentHeroNumber];
    
    //Update hero image
    _heroImg.image = [UIImage imageNamed:record.imageName];
    
    //Update table data
    tableHeroData = [NSArray arrayWithObjects: [@(record.strength) stringValue],
                     [@(record.agility) stringValue],
                     [@(record.intelect) stringValue],
                     [@(record.defense) stringValue], nil];
    
    [self.statTable reloadData];
}

//------------------BUTTONS------------------
//Retreat
- (IBAction)retreatClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set initial hero picture
    heroRecord* firstRecord = _heroes[0];
    _heroImg.image = [UIImage imageNamed:firstRecord.imageName];
    
    //Enable interactions on hero image
    _heroImg.userInteractionEnabled = YES;
    
    //Current hero img
    _currentHeroNumber=0;
    
    //Set total number of available heroes to the number of paed records
    _totalHeroNumber = (int)_heroes.count;
    
    //Table
    tableHeroData = [NSArray arrayWithObjects: [@(firstRecord.strength) stringValue],
                                               [@(firstRecord.agility) stringValue],
                                               [@(firstRecord.intelect) stringValue],
                                               [@(firstRecord.defense) stringValue], nil];
    tableOrcData = [NSArray arrayWithObjects: @"Orc 1", @"Orc 2", @"orc 3", @"Orc 4", nil];
    icons = [NSArray arrayWithObjects:@"sword.png", @"featherA.png", @"bookI.png", @"beltD.png", nil];
    
    _statTable.layer.borderWidth=2.0;
    _statTable.layer.borderColor=[UIColor orangeColor].CGColor;
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
