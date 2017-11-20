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

@end

@implementation VCFight

//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Test
    heroRecord* firstRecord = _heroes[0];
    _heroImg.image = [UIImage imageNamed:firstRecord.imageName];
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
