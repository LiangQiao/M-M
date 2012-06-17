//
//  MMViewController.m
//  Makan&Mug
//
//  Created by Leon Qiao on 27/5/12.
//  Copyright (c) 2012 qiaoliang89@gmail.com. All rights reserved.
//
#define FULL_SCREEN CGRectMake(0, 0, 320, 460)
#define SCREEN_CENTER CGPointMake(160, 230)

#import "MMViewController.h"
#import "MMLocationSelectController.h"

@interface MMViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *progressIndicator;
@property (nonatomic, strong) UIView *splashScreen;
@property BOOL netWorkAvailable;
@property NSString* purpose;
@end

@implementation MMViewController
@synthesize purpose;
@synthesize loginButton;
@synthesize shareButton;
@synthesize findButton;
@synthesize progressIndicator;
@synthesize splashScreen;
@synthesize netWorkAvailable;

- (void)tryLogin {
    //EFFECT: if session is valid --> get friends id
    //        if session is invalid --> login/app permission request if necessary
    
    //after login, fbDidLogin will get called and send notification, then-->get friends id
    FBConnector* fb = [FBConnector sharedFaceBookConnector];
    if (![fb login]) {
       // [fb.facebook authorize:nil];
        NSLog(@"[ViewController] is authorizing via facebook");
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginSucceed) name:@"FBDidLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginCancel) name:@"FBLoginCancelled" object:nil];
    } else {
        //request for friendsId
//        [self sendRequestForAppUser];
        NSLog(@"Logged in ");
        [self cancelSplashscreen];
        self.loginButton.hidden = true;
    }
    
    
}
- (IBAction)loginPressed:(id)sender {
    if([self connectedToInternet]){
        [self tryLogin];
    } else {
        [self showAlert];
    }
}

- (IBAction)sharePressed:(id)sender {
    [self goToSelect:@"share"]; //magic number bad!
}

- (IBAction)findPressed:(id)sender {
    [self goToSelect:@"find"]; //magic number bad!
}

- (void) didLoginSucceed {
    NSLog(@"didLoginSucceed");
    [self cancelSplashscreen];
    loginButton.hidden = true;
}

- (void) didLoginCancel {
    [self cancelSplashscreen];
    shareButton.hidden = true;
    findButton.hidden = true;
}

- (void) cancelSplashscreen {
    NSLog(@"cancelSplashscreen");
    //!! more need to be done
    [self.splashScreen removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    //yes we're connected
    //self.view.hidden = YES;
    self.netWorkAvailable = YES;
    [self.progressIndicator startAnimating];
}

- (void)viewDidAppear:(BOOL)animated{
    
    if ([self connectedToInternet]) {
          [self tryLogin];
    }
    else {
        [self showAlert];
    }

  
}

- (void)viewDidUnload
{   
    [self setLoginButton:nil];
    [self setShareButton:nil];
    [self setFindButton:nil];
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

#pragma mark - Segues

- (void) goToSelect: (NSString*) des {
    self.purpose = des;
    [self performSegueWithIdentifier:@"GoToSelect" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
	if ([segue.identifier isEqualToString:@"GoToSelect"]) {
        MMLocationSelectController *dest = (MMLocationSelectController*) segue.destinationViewController;
        dest.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        dest.purpose = self.purpose;
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

- (void) showAlert{
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

@end
