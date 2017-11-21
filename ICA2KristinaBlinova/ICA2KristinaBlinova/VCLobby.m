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

//Images
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;

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


@end

@implementation VCLobby

//VARIABLES
NSArray* tableData;
NSArray* icons;

NSMutableArray* statusLabels;

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
-(void) enablePlaceMode:(BOOL)toEnable
{
    _placeLbl.hidden=!toEnable;
    _firstBtn.hidden=!toEnable;
    _secondBtn.hidden=!toEnable;
    _thirdBtn.hidden=!toEnable;
    
//    NSString* btnLabel = [[NSString alloc] init];
//    if(toEnable)
//    {
//        _placeLbl.hidden=NO;
//        //btnLabel = @"Place here";
//        _fightBtn.hidden=toEnable;
//
//    }
//    else
//    {
//        _placeLbl.hidden=YES;
//        //btnLabel = @"View stats";
//    }
//    
//    [_firstBtn setTitle:btnLabel forState:UIControlStateNormal];
//    [_secondBtn setTitle:btnLabel forState:UIControlStateNormal];
//    [_thirdBtn setTitle:btnLabel forState:UIControlStateNormal];
    
}

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

//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize a hero record array with empty records
    heroRecord* emptyRecord = [[heroRecord alloc] init];
    _ownedHeroes = [NSMutableArray arrayWithObjects:emptyRecord, emptyRecord, emptyRecord, nil];
   
    //Disable fighting as no heroes exist
    _fightBtn.enabled=NO;
    
    //Set label to no placing heroes
    [self enablePlaceMode:NO];
    
    //Table
    tableData = [NSArray arrayWithObjects: @"Item 1", @"Item 2", @"Item 3", @"Item 4", nil];
    icons = [NSArray arrayWithObjects:@"sword.png", @"featherA.png", @"bookI.png", @"beltD.png", nil];
    
    //Status label array
    statusLabels = [NSMutableArray arrayWithObjects:_firstStatLbl, _secondStatLbl, _thirdStatLbl, nil];
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

//--------------------------------------------------------------------------------
//TABLE FUNCTIONS

//Number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

//Each row display
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"heroStats";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    //Choose a picture
    cell.imageView.image = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
    return cell;
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
