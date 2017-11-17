//
//  VCLobby.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 14/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCLobby.h"
#import "heroRecord.h"


@interface VCLobby ()

@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;

@end

@implementation VCLobby

//BUTTON CLICKS
- (IBAction)selectFirst:(UIButton *)sender
{
    [self setNewHero:_firstImg];
}

- (IBAction)selectSecond:(UIButton *)sender
{
    [self setNewHero:_secondImg];
}

- (IBAction)selectThird:(UIButton *)sender
{
    [self setNewHero:_thirdImg];
}

//FUNCTIONALITY
-(void) setNewHero:(UIImageView*)toImage
{
    if(_currentHeroID >0)
    {
        toImage.image = [UIImage imageNamed:@"Amazon.png"];
    }
    //Reset index
    self.currentHeroID=-1;
}


//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
   
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
