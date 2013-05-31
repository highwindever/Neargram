//
//  NGViewController.h
//  Neargram
//
//  Created by Feng Zhou on 2/21/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGViewController : UIViewController <UIWebViewDelegate>
- (IBAction)loginBtn:(id)sender;
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSString* accessToken;
@end
