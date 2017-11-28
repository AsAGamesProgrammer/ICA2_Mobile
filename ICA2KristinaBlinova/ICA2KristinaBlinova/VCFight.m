//
//  VCFight.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCFight.h"
#import "heroRecord.h"

@interface VCFight ()

@property (weak, nonatomic) IBOutlet UIImageView *heroImg;
@property (nonatomic) int currentHeroNumber;
@property (nonatomic) int totalHeroNumber;

@end

@implementation VCFight

//------------------TABLE--------------------
//VARIABLES
NSArray* tableData;
NSArray* icons;

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
    
    
    //Hero stats
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    //Choose a picture
    cell.imageView.image = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
    

    

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
    
    heroRecord* record = _heroes[_currentHeroNumber];
    _heroImg.image = [UIImage imageNamed:record.imageName];
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
    
    heroRecord* record = _heroes[_currentHeroNumber];
    _heroImg.image = [UIImage imageNamed:record.imageName];
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
    _totalHeroNumber = _heroes.count;
    
    //Table
    tableData = [NSArray arrayWithObjects: @"Item 1", @"Item 2", @"Item 3", @"Item 4", nil];
    icons = [NSArray arrayWithObjects:@"sword.png", @"featherA.png", @"bookI.png", @"beltD.png", nil];
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
