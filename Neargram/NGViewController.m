//
//  NGViewController.m
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import "NGViewController.h"

@interface NGViewController ()

@end

@implementation NGViewController

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

- (IBAction)loginBtn:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:self];
}
@end
