//
//  MMLocationSelectController.m
//  Makan&Mug
//
//  Created by Leon Qiao on 10/6/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//

#import "MMLocationSelectController.h"
#import "MMShareViewController.h"
#import "MMFindViewController.h"

@interface MMLocationSelectController ()
@property Location location;
@end

@implementation MMLocationSelectController
@synthesize purpose;
@synthesize canScrollView;
@synthesize libScrollView;
@synthesize location;
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
    UIButton* buttonClicked = (UIButton*)sender;
     NSLog(@"%d", buttonClicked.tag);
    self.location = buttonClicked.tag;
    if([self.purpose isEqualToString:@"find"]) {
        [self performSegueWithIdentifier:@"GoToFind" sender:self];
    } else {
        [self performSegueWithIdentifier:@"GoToShare" sender:self];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
	
    if ([segue.identifier isEqualToString:@"GoToShare"]) {
        MMShareViewController *dest = (MMShareViewController*) segue.destinationViewController;
        dest.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        dest.location = self.location;
       
    }
    
	if ([segue.identifier isEqualToString:@"GoToFind"]) {
        MMFindViewController *dest = (MMFindViewController*) segue.destinationViewController;
        dest.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        dest.location = self.location;
    }
	
}


@end
