//
//  NGViewController.m
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import "NGViewController.h"
#import "JSON.h"
#import "NGTabBarViewController.h"
#import "NGMeViewController.h"
#import "HSInstagram.h"
#import "HSInstagramUserMedia.h"

#define kKeychainItemName @"InstagramOauth2: Instagram"
#define InstagramID @"7ec23206ed754a5bb9e19da6cc175140" //this is set by Instagram when registering an app with the API
#define InstagramSecret @"207c69c7b7ae4a82a8b9d069eeae8300" //this is set by Instagram when registering an app with the API
#define InstagramCallbackURI @"http://www.columbia.edu/~fz2172/project.html"

@interface NGViewController ()

@end

@implementation NGViewController

@synthesize webView = _webView;
@synthesize accessToken = _accessToken;

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




#pragma mark - Web view delegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.URL.absoluteString rangeOfString:@"#"].location != NSNotFound) {
        NSString* params = [[request.URL.absoluteString componentsSeparatedByString:@"#"] objectAtIndex:1];
        self.accessToken = [params stringByReplacingOccurrencesOfString:@"access_token=" withString:@""];
        self.webView.hidden = YES;
        [self performSegueWithIdentifier:@"login" sender:self];
        [self IGGetAndSaveUserInfo:self.accessToken];
        //[self requestImages];
        
        //        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        //        [defaults setObject:self.accessToken forKey:kUserAccessTokenKey];
        //        [defaults synchronize];
        
    }
    
	return YES;
}

- (void)requestImages
{
    [HSInstagramUserMedia getUserMediaWithId:@"self" withAccessToken:self.accessToken block:^(NSArray *records) {
        
        for (HSInstagramUserMedia* media in records) {
            NSLog(@"url:%@ likes:%i",media.standardUrl,media.likes);
        }
        
    }];
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
        [tvc setAToken:self.accessToken];
        [mevc setAToken:self.accessToken];

        
    }
    
    
    
}



- (IBAction)loginBtn:(id)sender {
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    NSURLRequest* request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:
                                  [NSString stringWithFormat:kAuthenticationEndpoint, kClientId, kRedirectUrl]]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

    
}
@end
