//
//  MyPhotoViewController.h
//  Neargram
//
//  Created by Feng Zhou on 3/15/13.
//  Copyright (c) 2013 Feng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPhotoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *filterlabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) id photo;//Json of the IG photo info
@end
