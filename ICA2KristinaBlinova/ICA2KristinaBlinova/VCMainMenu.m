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

- (BOOL)shouldAutorotate

{
    return NO;
}

//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Creates a facebook log in button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    //Places the button in the center of the view
    loginButton.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height - 40);
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    
    //Set itself as a delegate
    loginButton.delegate = self;
    
    //Check if user is logged into a facebook
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

//LOGIN
- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    //If user is logged in - set a name
    [self setFacebookName];
}

//LOGOUT
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    //After logout pop a warning
    _nameLbl.text = @"Welcome, Warrior!";
    _facebookNotificationLbl.hidden=NO;
}

//WARNING
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//SET FACEBOOK NAME
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
