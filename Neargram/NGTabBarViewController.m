//
//  NGTabBarViewController.m
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import "NGTabBarViewController.h"
#import "NGNearbyViewController.h"
#import "NGMeViewController.h"

@interface NGTabBarViewController ()

@end

@implementation NGTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    NGNearbyViewController *nvc = [[NGNearbyViewController alloc] init];
//    NGMeViewController *mevc =[[NGMeViewController alloc] init];
//    NSArray *viewControllers = [NSArray arrayWithObjects:nvc,mevc, nil];
//    [self setViewControllers:viewControllers animated:YES];
    NSLog(@"print token:%@",self.aToken);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
