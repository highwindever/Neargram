//
//  NGViewController.m
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import "NGViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "JSON.h"
#import "NGTabBarViewController.h"
#import "NGMeViewController.h"

#define kKeychainItemName @"InstagramOauth2: Instagram"
#define InstagramID @"7ec23206ed754a5bb9e19da6cc175140" //this is set by Instagram when registering an app with the API
#define InstagramSecret @"207c69c7b7ae4a82a8b9d069eeae8300" //this is set by Instagram when registering an app with the API
#define InstagramCallbackURI @"http://www.columbia.edu/~fz2172/project.html"

@interface NGViewController ()

@end

@implementation NGViewController
@synthesize aToken = _aToken;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IGProcess
- (IBAction)IGLoginHandler:(id)sender {
    [self signInToInstagram];
    
}

- (void) signOut
{
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
}

- (GTMOAuth2Authentication *) authForInstagram
{
    //This URL is defined by the individual 3rd party APIs, be sure to read their documentation
    NSURL *tokenURL = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"Instagram"
                                                             tokenURL:tokenURL
                                                          redirectURI:InstagramCallbackURI
                                                             clientID:InstagramID
                                                         clientSecret:InstagramSecret];
    auth.scope = @"basic";
    NSLog(@"1,%@",[auth description]);
    return auth;
}


- (void)signInToInstagram
{
    
    [self signOut];
    
    GTMOAuth2Authentication *auth = [self authForInstagram];
    auth.scope=@"basic";
    if (auth.canAuthorize) {
        //bypass the login
        //do something!!!!!!!!
        NSLog(@"ig ouath already yes!!!!!");
        return;
    }
    
    NSURL *authURL = [NSURL URLWithString:@"https://api.instagram.com/oauth/authorize"];
    
    // Display the authentication view
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
                                                                 authorizationURL:authURL
                                                                 keychainItemName:kKeychainItemName
                                                                         delegate:self
                                                                 finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    
    [self.navigationController pushViewController:viewController animated:NO];
    
    //    self.navigationItem.backBarButtonItem =
    //    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
    //                                     style:UIBarButtonItemStyleBordered
    //                                    target:nil
    //                                    action:nil];//bug:hit cancel button will display error message.
    
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error
{
    //[self.navigationController popToViewController:self animated:NO];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    if (error != nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error Authorizing with Instagram"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        //Authorization was successful - get location information
        //do something!!!!!!!!
        //NSLog(@"access token is %@",auth.accessToken);
        self.aToken =auth.accessToken;
        [self performSegueWithIdentifier:@"login" sender:self];
        [self IGGetAndSaveUserInfo:self.aToken];
    }
}

-(void) IGGetAndSaveUserInfo:(NSString *)igAccess_token
{
    NSURL *userUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self?access_token=%@",igAccess_token]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:userUrl];
    NSURLResponse *response = nil;
    NSError *error =nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *str =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"IG user data: %@",str);
    NSDictionary *results = [str JSONValue];
    NSDictionary *iguser = [results objectForKey:@"data"];
    NSString *igUsername = [iguser objectForKey:@"username"];
    NSLog(@"json username:%@",igUsername);    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"login"]) {
        
        // Get destination view
        NGTabBarViewController *tvc = [segue destinationViewController];
        NGMeViewController *mevc =[[NGMeViewController alloc] init];
        mevc = (NGMeViewController *)[[tvc viewControllers] objectAtIndex:1];
        [tvc setAToken:self.aToken];
        [mevc setAToken:self.aToken];

        
    }
    
    
    
}



- (IBAction)loginBtn:(id)sender {
    
    [self signInToInstagram];
    
}
@end
