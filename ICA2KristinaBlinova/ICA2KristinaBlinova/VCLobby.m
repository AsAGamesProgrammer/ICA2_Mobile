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

@end

@implementation VCLobby

//Button actions
- (IBAction)selectFirst:(UIButton *)sender
{
    if(_currentHeroID >0)
    {
        _firstImg.image = [UIImage imageNamed:@"Amazon.png"];
    }
}

- (IBAction)selectSecond:(UIButton *)sender
{
    
}

- (IBAction)selectThird:(UIButton *)sender
{
    
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
