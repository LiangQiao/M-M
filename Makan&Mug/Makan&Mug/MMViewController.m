//
//  MMViewController.m
//  Makan&Mug
//
//  Created by Leon Qiao on 27/5/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//
#define FULL_SCREEN CGRectMake(0, 0, 1024, 768)
#define SCREEN_CENTER CGPointMake(512, 384)

#import "MMViewController.h"


@interface MMViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *progressIndicator;
@property (nonatomic, strong) UIView *splashScreen;
@property BOOL netWorkAvailable;
@end

@implementation MMViewController
@synthesize progressIndicator;
@synthesize splashScreen;
@synthesize netWorkAvailable;

- (void)tryLogin {
    //EFFECT: if session is valid --> get friends id
    //        if session is invalid --> login/app permission request if necessary
    
    //after login, fbDidLogin will get called and send notification, then-->get friends id
    FBConnector* fb = [FBConnector sharedFaceBookConnector];
    if (![fb login]) {
        [fb.facebook authorize:nil];
        NSLog(@"[ViewController] is authorizing via facebook");
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequestForAppUser) name:@"FBDidLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelSplashscreen) name:@"FBLoginCancelled" object:nil];
    } else {
        //request for friendsId
//        [self sendRequestForAppUser];
        NSLog(@"Logged in ");
    }
    
    
}

- (void)viewDidLoad
{
    NSLog(@"start..");
    [super viewDidLoad];
    // spinner on a splashscreen
    self.progressIndicator = [[UIActivityIndicatorView alloc]init];
    self.progressIndicator.center = SCREEN_CENTER;
    [progressIndicator sizeToFit];
    self.progressIndicator.hidesWhenStopped = YES;
    progressIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.splashScreen = [[UIView alloc] initWithFrame:FULL_SCREEN];
    splashScreen.backgroundColor = [UIColor blackColor];
    [self.splashScreen addSubview:progressIndicator];
    [self.view addSubview:splashScreen];
    
    
    if ([self connectedToInternet]) {
        //yes we're connected
        //self.view.hidden = YES;
        self.netWorkAvailable = YES;
        [self.progressIndicator startAnimating];
        [self tryLogin];
    }
    else {
        //no we're not connected
        self.netWorkAvailable = NO;
        UIAlertView *invalidGameStartAlert = [[UIAlertView alloc] 
                                              initWithTitle:@"Cannot start game"
                                              message:@"Sorry, you have no network connection" 
                                              delegate:nil 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles:nil];
        [invalidGameStartAlert show];  
    }
}

- (void)viewDidUnload
{   
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


#pragma mark - Checking Connection availability

- (BOOL) connectedToInternet
{
    // quick and dirty
    NSError* error = nil;
    NSURL* url = [[NSURL alloc] initWithString:@"http://www.google.com"];
    NSString *URLString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    return ( URLString != NULL ) ? YES : NO;
}

@end
