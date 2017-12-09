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
@property (weak, nonatomic) IBOutlet UILabel *facebookNotificationLbl;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@end

@implementation VCMainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height - 40);
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    
    //Set itself as a delegate
    loginButton.delegate = self;
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [self setFacebookName];
    }
    else
    {
        _nameLbl.text = @"Welcome, Warrior!";
        _facebookNotificationLbl.hidden=NO;
    }
    // Do any additional setup after loading the view.
}

//---------------------------------------------------
//          LOG IN TO FACEBOOK ACTIONS
//---------------------------------------------------

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    //use your custom code here
    //redirect after successful login
    // User is logged in, do work such as go to next view controller.
    [self setFacebookName];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    //use your custom code here
    //redirect after successful logout
    _nameLbl.text = @"Welcome, Warrior!";
    _facebookNotificationLbl.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setFacebookName
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters: @{@"fields": @"id, name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error)
         {
             //NSLog(@"fetched user:%@", result);
             _nameLbl.text =[result valueForKey:@"name"];
             //Localisation
             NSString *welcome = NSLocalizedString(@"Welcome", nil);
             [_nameLbl setText:[NSString stringWithFormat:@"%@ %@", welcome, [result valueForKey:@"name"]]];
             
         }
         else
             NSLog(@"Oooops");
     }];
    
    _facebookNotificationLbl.hidden=YES;
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
