//
//  MyPhotoViewController.m
//  Neargram
//
//  Created by Feng Zhou on 3/15/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import "MyPhotoViewController.h"

@interface MyPhotoViewController ()

@end

@implementation MyPhotoViewController

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
    [self.userNameLabel setText:[[self.photo objectForKey:@"user"] objectForKey:@"username"]];
    [self.filterlabel setText:[self.photo objectForKey:@"filter"]];
    //[self.imageView setImage:[UIImage imageWithContentsOfFile:]];
    
    NSString *ImageURL = [[[self.photo objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    
    NSLog(@"Photo url: %@",[[[self.photo objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
