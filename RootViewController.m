//
//  RootViewController.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 25..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize ssViewController, seViewController,stViewController, smViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Shake Action Process

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    srandom(time(NULL));
    int dec = random() % 4;
    
    NSLog([NSString stringWithFormat:@"Shaking start : random = %d", dec]);
    
    ArtClockAppDelegate *appDelegate = (ArtClockAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view removeFromSuperview];
    if (dec == 0) {
        smViewController = [[SunAndMoonViewController alloc] initWithNibName:@"SunAndMoonViewController" bundle:nil];
        
        appDelegate.window.rootViewController = smViewController;	
        [appDelegate.window addSubview:smViewController.view];
    } else if (dec == 1) {
        ssViewController = [[SkyAndStarsViewController alloc] initWithNibName:@"SkyAndStarsViewController" bundle:nil];
        
        appDelegate.window.rootViewController = ssViewController;	
        [appDelegate.window addSubview:ssViewController.view];
    } else if (dec == 2) {
        seViewController = [[SunAndEarthViewcontroller alloc] initWithNibName:@"SunAndEarthViewcontroller" bundle:nil];
        
        appDelegate.window.rootViewController = seViewController;	
        [appDelegate.window addSubview:seViewController.view];
    } else {
        stViewController = [[SkyAndTreeViewController alloc] initWithNibName:@"SkyAndTreeViewController" bundle:nil];
        
        appDelegate.window.rootViewController = stViewController;	
        [appDelegate.window addSubview:stViewController.view];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"Shaking cancel");  
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
     ArtClockAppDelegate *appDelegate = (ArtClockAppDelegate *)[[UIApplication sharedApplication] delegate];
    smViewController = [[SunAndMoonViewController alloc] initWithNibName:@"SunAndMoonViewController" bundle:nil];
    
    appDelegate.window.rootViewController = smViewController;	
    [appDelegate.window addSubview:smViewController.view];
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidUnload
{
    [ssViewController release];
    [seViewController release];
    [stViewController release];
    [smViewController release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
