//
//  MMLocationSelectController.h
//  Makan&Mug
//
//  Created by Leon Qiao on 10/6/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMLocationSelectController : UIViewController
@property NSString* purpose;
@property (weak, nonatomic) IBOutlet UIScrollView *canScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *libScrollView;
@end
