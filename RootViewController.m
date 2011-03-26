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
@synthesize customClockView;
@synthesize customCompassView;

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
    
//    NSLog([NSString stringWithFormat:@"Shaking start : random = %d", dec]);
    
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
    if (currentTag == -1) {
        float wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        [customCompassView resizeView:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        [UIView commitAnimations];
        
        currentTag = 2;
    } else if(currentTag == 0) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [calView resizeCalendar:CGRectMake(10.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        [customClockView resizeClock:CGRectMake(85.0f, 460 - (wcalHeight / 3) - 10 - ((wcalHeight - (wcalHeight / 3)) / 2), wcalHeight, wcalHeight / 3)];
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customCompassView resizeView:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        [UIView commitAnimations];
        
        currentTag = 2;
    } else if(currentTag == 1) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(10.0f, 460 - (wcalHeight / 3) - 10 - ((wcalHeight - (wcalHeight / 3)) / 2), wcalHeight, wcalHeight / 3)];
        [customCompassView resizeView:CGRectMake(85.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [calView resizeCalendar:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        currentTag = 0;
    } else if(currentTag == 2) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        [calView resizeCalendar:CGRectMake(85.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        [customCompassView resizeView:CGRectMake(10.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(10.0f, (460 / 2) - ((wcalHeight / 3) / 2) - 30, wcalHeight, wcalHeight / 3)];
        
        [UIView commitAnimations];
        
        currentTag = 1;
    }
}

- (void)swipeRightAction:(id)ignored {
    float wcalHeight = 300.0f;
    
    if (currentTag == -1) {
        float wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [calView resizeCalendar:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(10.0f, 460 - (wcalHeight / 3) - 10 - ((wcalHeight - (wcalHeight / 3)) / 2), wcalHeight, wcalHeight / 3)];
        
        [customCompassView resizeView:CGRectMake(85.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        currentTag = 0;
    } else if(currentTag == 0) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customCompassView resizeView:CGRectMake(10.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        [calView resizeCalendar:CGRectMake(85.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(10.0f, (460 / 2) - ((wcalHeight / 3) / 2) - 30, wcalHeight, wcalHeight / 3)];
        
        [UIView commitAnimations];
        
        currentTag = 1;
    } else if(currentTag == 1) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(85.0f, 460 - (wcalHeight / 3) - 10 - ((wcalHeight - (wcalHeight / 3)) / 2), wcalHeight, wcalHeight / 3)];
        [calView resizeCalendar:CGRectMake(10.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
    
        [customCompassView resizeView:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        [UIView commitAnimations];
        
        currentTag = 2;
    } else if(currentTag == 2) {
        float wcalHeight = 70.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [customClockView resizeClock:CGRectMake(10.0f, 460 - (wcalHeight / 3) - 10 - ((wcalHeight - (wcalHeight / 3)) / 2), wcalHeight, wcalHeight / 3)];
        [customCompassView resizeView:CGRectMake(85.0f, 460 - wcalHeight - 10, wcalHeight, wcalHeight)];
        [UIView commitAnimations];
        
        wcalHeight = 300.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        // we need to perform some post operations after the animation is complete
        [UIView setAnimationDelegate:self];
        
        [calView resizeCalendar:CGRectMake(10.0f, (460 / 2) - (wcalHeight / 2) - 10, wcalHeight, wcalHeight)];
        
        [UIView commitAnimations];
        
        currentTag = 0;
    }
    
    
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
    
    currentTag = -1;
    
    float calHeight = 70.0f;
    
    calView = [[MyCalendarView alloc] initWithFrame:CGRectMake(10.0f, 460 - calHeight - 10, calHeight, calHeight) delegate:self];
    calView.tag = 0;
    [self.view addSubview:calView];
    [self.view bringSubviewToFront:calView];
    
    customClockView = [[TextBasedDigitalClockView alloc]  initWithFrame:CGRectMake(85.0f, 460 - (calHeight / 3) - 10 - ((calHeight - calHeight / 3) / 2), calHeight, calHeight / 3)];
    customClockView.tag = 1;
    [self.view addSubview:customClockView];
    [self.view bringSubviewToFront:customClockView];
    [customClockView startClockProcessor];
    
    customCompassView = [[CustomCompassView alloc]  initWithFrame:CGRectMake(160.0f, 460 - calHeight - 10, calHeight, calHeight)];
    customCompassView.tag = 2;
    [self.view addSubview:customCompassView];
    [self.view bringSubviewToFront:customCompassView];
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
    [customClockView release];
    [customCompassView release];
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
