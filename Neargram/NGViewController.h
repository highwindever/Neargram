//
//  NGViewController.h
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGViewController : UIViewController
- (IBAction)loginBtn:(id)sender;
@property (nonatomic,strong)NSString* aToken;
@end
