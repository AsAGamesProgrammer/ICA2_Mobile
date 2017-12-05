//
//  VCMainMenu.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 20/11/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "VCMainMenu.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface VCMainMenu ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end

@implementation VCMainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height - 40);
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        // User is logged in, do work such as go to next view controller.
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 NSString *photostring=[[[result valueForKey:@"picture"] objectForKey:@"data"] valueForKey:@"url"];
                 photostring = [photostring stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
                 
                 NSLog(@"all data here is:%@",result);
                 NSLog(@"username is :%@",[result valueForKey:@"name"]);
                 //NSLog(@"fetched user:%@", result);
                 _nameLbl.text =[result valueForKey:@"name"];
                 
             }
             else
                 NSLog(@"Oooops");
         }];
    }
    else
    {
        _nameLbl.text = @"Welcome, Warrior!";
    }
    // Do any additional setup after loading the view.
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
