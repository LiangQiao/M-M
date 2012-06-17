//
//  MMLocationSelectController.m
//  Makan&Mug
//
//  Created by Leon Qiao on 10/6/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//

#import "MMLocationSelectController.h"

@interface MMLocationSelectController ()

@end

@implementation MMLocationSelectController
@synthesize purpose;
@synthesize canScrollView;
@synthesize libScrollView;
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
    self.canScrollView.contentSize = CGSizeMake(160, 832);
    self.libScrollView.contentSize = CGSizeMake(160, 832);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCanScrollView:nil];
    [self setLibScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button handlers
- (IBAction)locationButtonPressed:(id)sender {
    
}


@end
