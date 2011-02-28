//
//  RootViewController.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 2. 25..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import "RootViewController.h"



@implementation RootViewController

//@synthesize ssViewController, seViewController,stViewController, smViewController;
@synthesize bgImageView;
@synthesize calView;


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
    
//    ArtClockAppDelegate *appDelegate = (ArtClockAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [self.view removeFromSuperview];
    if (dec == 0) {
//        smViewController = [[SunAndMoonViewController alloc] initWithNibName:@"SunAndMoonViewController" bundle:nil];
        
//        appDelegate.window.rootViewController = smViewController;	
//        [appDelegate.window addSubview:smViewController.view];
        
        self.bgImageView.image = [UIImage imageNamed:@"sunandmoon.png"];
    } else if (dec == 1) {
//        ssViewController = [[SkyAndStarsViewController alloc] initWithNibName:@"SkyAndStarsViewController" bundle:nil];
        
//        appDelegate.window.rootViewController = ssViewController;	
//        [appDelegate.window addSubview:ssViewController.view];
        self.bgImageView.image = [UIImage imageNamed:@"skyandstars.png"];
    } else if (dec == 2) {
//        seViewController = [[SunAndEarthViewcontroller alloc] initWithNibName:@"SunAndEarthViewcontroller" bundle:nil];
        
//        appDelegate.window.rootViewController = seViewController;	
//        [appDelegate.window addSubview:seViewController.view];
        self.bgImageView.image = [UIImage imageNamed:@"sunandearth.png"];
    } else {
//        stViewController = [[SkyAndTreeViewController alloc] initWithNibName:@"SkyAndTreeViewController" bundle:nil];
        
//        appDelegate.window.rootViewController = stViewController;	
//        [appDelegate.window addSubview:stViewController.view];
        self.bgImageView.image = [UIImage imageNamed:@"skyandtree.png"];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"Shaking cancel");  
}

#pragma mark - Swipe Methods

- (void)swipeLeftAction:(id)ignored {
    float ncalHeight = 70.0f;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    // we need to perform some post operations after the animation is complete
    [UIView setAnimationDelegate:self];

    [calView resizeCalendar:CGRectMake(10.0f, (480 / 2) - (ncalHeight / 2), ncalHeight, ncalHeight)];
 //   calView.frame = CGRectMake(10.0f, (480 / 2) - (ncalHeight / 2), ncalHeight, ncalHeight);

    /*
    [calView removeFromSuperview];
    calView = [[MyCalendarView alloc] initWithFrame:CGRectMake(10.0f, (480 / 2) - (calHeight / 2), calHeight, calHeight) delegate:nil withManagedObjectContext:nil];
    [self.view addSubview:calView];
    [self.view bringSubviewToFront:calView];
    */
    [UIView commitAnimations];
}

- (void)swipeRightAction:(id)ignored {
    float wcalHeight = 300.0f;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    // we need to perform some post operations after the animation is complete
    [UIView setAnimationDelegate:self];
    
    [calView resizeCalendar:CGRectMake(10.0f, (480 / 2) - (wcalHeight / 2), wcalHeight, wcalHeight)];
    
    [UIView commitAnimations];
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

    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //swipeLeft.delegate = self;
    [self.view addGestureRecognizer:swipeLeft];
    
    //Swipe Right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    //swipeRight.delegate = self;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)loadView {
    [super loadView];
    NSLog(@"loadView");
    float calHeight = 70.0f;
    
    calView = [[MyCalendarView alloc] initWithFrame:CGRectMake(10.0f, (480 / 2) - (calHeight / 2), calHeight, calHeight) delegate:self withManagedObjectContext:nil];
    [self.view addSubview:calView];
    [self.view bringSubviewToFront:calView];
    
    
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
    /*
    [ssViewController release];
    [seViewController release];
    [stViewController release];
    [smViewController release];
     */
    
    [bgImageView release];
    [calView release];

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
