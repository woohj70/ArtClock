//
//  SunAndMoonViewController.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 24..
//  Copyright 2011 Mazdah.com. All rights reserved.
//

#import "SunAndMoonViewController.h"

#import "SkyAndStarsViewController.h"
#import "SunAndEarthViewcontroller.h"
#import "SkyAndTreeViewController.h"

@implementation SunAndMoonViewController

@synthesize ssViewController, seViewController,stViewController;

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

/*
#pragma mark - Shake Action Process

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"Shaking start");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    srandom(time(NULL));
    int dec = random() % 3;
    
    ArtClockAppDelegate *appDelegate = (ArtClockAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view removeFromSuperview];
    if (dec == 0) {
        ssViewController = [[SkyAndStarsViewController alloc] initWithNibName:@"SkyAndStarsViewController" bundle:nil];
        
        appDelegate.window.rootViewController = ssViewController;	
        [appDelegate.window addSubview:ssViewController.view];
    } else if (dec == 1) {
        seViewController = [[SunAndEarthViewcontroller alloc] initWithNibName:@"SunAndEarthViewcontroller" bundle:nil];
        
        appDelegate.window.rootViewController = seViewController;	
        [appDelegate.window addSubview:seViewController.view];
    } else {
        stViewController = [[SkyAndTreeViewController alloc] initWithNibName:@"SkyAndTreeViewController" bundle:nil];
        
        appDelegate.window.rootViewController = stViewController;	
        [appDelegate.window addSubview:stViewController.view];
    }
    
    NSLog(@"Shaking end");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"Shaking cancel");  
}
*/

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
*/

- (void)viewDidUnload
{
    [ssViewController release];
    [seViewController release];
    [stViewController release];
    
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
