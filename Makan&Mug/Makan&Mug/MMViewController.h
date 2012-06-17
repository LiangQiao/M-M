//
//  MMViewController.h
//  Makan&Mug
//
//  Created by Leon Qiao on 27/5/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnector.h"

@interface MMViewController : UIViewController <FBRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *findButton;

@end
