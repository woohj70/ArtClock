//
//  CustomCompassView.m
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 26..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import "CustomCompassView.h"


@implementation CustomCompassView

@synthesize bgView, compassView;
@synthesize dgreeLabel;
@synthesize addrLabel;
@synthesize locManager, reversGeo;
#pragma mark -
#pragma mark Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lotation = 0.0f;
        // Initialization code
        // Initialization code
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
        bgView.image = [UIImage imageNamed:@"compassBg.png"];
        [self addSubview:bgView];
        
        // Initialization code
        compassView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        compassView.image = [UIImage imageNamed:@"compass.png"];
        
        [self addSubview:compassView];
        
        addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 10.0f, 240.0f, 20.0f)];
        addrLabel.font = [UIFont systemFontOfSize:12.0f];
        addrLabel.textColor = [UIColor blackColor];
        addrLabel.textAlignment = UITextAlignmentCenter;
        addrLabel.backgroundColor = [UIColor whiteColor];
        addrLabel.opaque = NO;
        addrLabel.alpha = 0.6;
        [self addSubview:addrLabel];
        addrLabel.hidden = YES;
        
        dgreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 270.0f, 110.0f, 20.0f)];
        dgreeLabel.font = [UIFont systemFontOfSize:12.0f];
        dgreeLabel.textColor = [UIColor blackColor];
        dgreeLabel.textAlignment = UITextAlignmentCenter;
        dgreeLabel.backgroundColor = [UIColor whiteColor];
        dgreeLabel.opaque = NO;
        dgreeLabel.alpha = 0.6;
        [self addSubview:dgreeLabel];
        dgreeLabel.hidden = YES;
        
        locManager = [[CLLocationManager alloc] init];
        [locManager setDelegate:self];
        
        [locManager startUpdatingLocation];
        
        if (locManager.headingAvailable == NO) {
            // No compass is available. This application cannot function without a compass, 
            // so a dialog will be displayed and no magnetic data will be measured.
            self.locManager = nil;
            UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [noCompassAlert show];
            [noCompassAlert release];
        } else {
            // heading service configuration
            locManager.headingFilter = kCLHeadingFilterNone;
            
            // start the compass
            [locManager startUpdatingHeading];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [bgView release];
    [compassView release];
    
    [dgreeLabel release];
    [addrLabel release];
    [locManager release];
    [reversGeo release];
    [super dealloc];
}

#pragma mark -
#pragma mark Move and Resize

- (void)moveCalendar:(CGRect)frame {
    self.frame = frame;
}

- (void)resizeView:(CGRect)frame {
    self.frame = frame;
    //    self.bounds = frame;
    
    [bgView removeFromSuperview];
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height)];
    bgView.image = [UIImage imageNamed:@"compassBg.png"];
    [self addSubview:bgView];
    
    [compassView removeFromSuperview];
    if (self.bounds.size.width == 70) {
        compassView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        compassView.image = [UIImage imageNamed:@"compass.png"];
        [self addSubview:compassView];
        
        dgreeLabel.hidden = YES;
        addrLabel.hidden = YES;
    } else {
        int condition = FULL_SIZE_COMPASS;
        if (condition == 1) {
            compassView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 10, self.bounds.size.height / 2 - 10, self.bounds.size.width / 2, self.bounds.size.height / 2)];
            compassView.image = [UIImage imageNamed:@"compass.png"];
        } else {
            compassView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
            compassView.image = [UIImage imageNamed:@"compassL.png"];
        }
        [self addSubview:compassView];
        
        dgreeLabel.hidden = NO;
        addrLabel.hidden = NO;
        
        [self bringSubviewToFront:dgreeLabel];
        [self bringSubviewToFront:addrLabel];
    }
    
    
    

    
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	[geocoder cancel];
	[geocoder autorelease];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	NSString *str = [NSString stringWithFormat:@""];

    //	str = [str stringByAppendingFormat:@"%@", placemark.country];
    //	country = placemark.country;
	
	if([placemark.administrativeArea length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.administrativeArea];
	}
	
	if([placemark.subAdministrativeArea length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.subAdministrativeArea];
	}
	
	if([placemark.locality length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.locality];
	}
	
	if([placemark.subLocality length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.subLocality];
	}
	
	if([placemark.thoroughfare length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.thoroughfare];
	}
	
	if([placemark.subThoroughfare length] > 0)
	{
		str = [str stringByAppendingFormat:@" "];
		str = [str stringByAppendingFormat:@"%@", placemark.subThoroughfare];
	}
	
	self.addrLabel.text = str;    // 최종 주소
    
}

#pragma mark -
#pragma mark CLLocationManagerDelegate


-(NSMutableArray*) createLocArray:(double) val{
	val = fabs(val);
	NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
	double deg = (int)val;
	[array addObject:[NSNumber numberWithDouble:deg]];
	val = val - deg;
	val = val*60;
	double minutes = (int) val;
	[array addObject:[NSNumber numberWithDouble:minutes]];
	val = val - minutes;
	val = val *60;
	double seconds = val;
	[array addObject:[NSNumber numberWithDouble:seconds]];
	return array;
} 

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	CLLocationCoordinate2D newloc = [newLocation coordinate];
	//	CLLocationCoordinate2D oldloc = [newLocation coordinate];
	
	if (newloc.latitude == latitude && newloc.longitude == longitude) {
		return;
	}
	
	shareLoc.latitude = newloc.latitude;
	shareLoc.longitude = newloc.longitude;
	
	latitude = newloc.latitude;
	longitude = newloc.longitude;
//	altitude = newLocation.altitude;
	
//	reversGeo = [[MKReverseGeocoder alloc] initWithCoordinate:shareLoc];
//	reversGeo.delegate = self;
//	[reversGeo start];
	
	NSMutableArray *latArr = [self createLocArray:newloc.latitude];
	NSMutableArray *lonArr = [self createLocArray:newloc.longitude];
    
    NSString *lat = @"";
    NSString *lon = @"";
	
	if (newloc.latitude > 0) {
		lat = [NSString stringWithFormat:@"%.0f° %.0f′ %.0f″ N", [[latArr objectAtIndex:0] doubleValue], [[latArr objectAtIndex:1] doubleValue], [[latArr objectAtIndex:2] doubleValue]];
	} else {
		lat = [NSString stringWithFormat:@"%.0f° %.0f′ %.0f″ S", [[latArr objectAtIndex:0] doubleValue], [[latArr objectAtIndex:1] doubleValue], [[latArr objectAtIndex:2] doubleValue]];
	}
	
	if (newloc.longitude > 0) {
		lon = [NSString stringWithFormat:@"%.0f° %.0f′ %.0f″ E", [[lonArr objectAtIndex:0] doubleValue], [[lonArr objectAtIndex:1] doubleValue], [[lonArr objectAtIndex:2] doubleValue]];
	} else {
		lon = [NSString stringWithFormat:@"%.0f° %.0f′ %.0f″ W", [[lonArr objectAtIndex:0] doubleValue], [[lonArr objectAtIndex:1] doubleValue], [[lonArr objectAtIndex:2] doubleValue]];
	}
	
    self.addrLabel.text = [NSString stringWithFormat:@"%@   %@", lat, lon];
	//	[latArr release];
	//	[lonArr release];
	
//	self.altField.text = [NSString stringWithFormat:@"%.3f m", newLocation.altitude];
	
	
}

- (void)showAlertView:(NSString *)message andTitle:(NSString *)title {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title 
						  message:message
						  delegate:nil 
						  cancelButtonTitle:@"OK" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	switch([error code])
	{
		case kCLErrorNetwork: // general, network-related error
		{
			[self showAlertView:@"please check your network connection or that you are not in airplane mode" andTitle:@"Error"];
		}
			break;
		case kCLErrorDenied:{
			[self showAlertView:@"user has denied to use current Location" andTitle:@"Error"];
		}
			break;
		default:
		{
			[self showAlertView:@"unknown network error" andTitle:@"Error"];
		}
			break;
	}
	
	[self.locManager stopUpdatingHeading];
	[self.locManager stopUpdatingLocation];
	
}

-(void)Rotation_Image_View:(BOOL)bUP andDegree:(NSInteger) degree
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5f];
	CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI / 180 * degree);
	compassView.transform = trans;
	
	[UIView commitAnimations];
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
    //	[xLabel setText:[NSString stringWithFormat:@"%.1f", heading.x]];
    //	[yLabel setText:[NSString stringWithFormat:@"%.1f", heading.y]];
    //	[zLabel setText:[NSString stringWithFormat:@"%.1f", heading.z]];
    
    // Compute and display the magnitude (size or strength) of the vector.
	//      magnitude = sqrt(x^2 + y^2 + z^2)
    //	CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    //[directionLabel setText:[NSString stringWithFormat:@"%.1f", magnitude]];
    //	[directionLabel setText:[NSString stringWithFormat:@"%.0f : %.0f", heading.trueHeading, heading.magneticHeading]];
	
	NSInteger gap = [[NSNumber numberWithDouble:heading.trueHeading] integerValue];
	
	if (gap <= 22 || gap >= 338) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° N", gap]];
	} else if (gap <= 69 && gap >= 23) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° NE", gap]];
	} else if (gap >= 68 && gap <= 112) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° E", gap]];
	} else if (gap >= 113 && gap <= 157) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° SE", gap]];
	} else if (gap >= 158 && gap <= 202) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° S", gap]];
	} else if (gap >= 203 && gap <= 247) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° SW", gap]];
	} else if (gap >= 248 && gap <= 292) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° W", gap]];
	} else if (gap >= 293 && gap <= 337) {
		[self.dgreeLabel setText:[NSString stringWithFormat:@"%d° NW", gap]];
	}
	
	if (lotation > heading.trueHeading) {
		[self Rotation_Image_View:NO andDegree:gap * -1];
	} else if (lotation < heading.trueHeading) {
		[self Rotation_Image_View:YES andDegree:360 - gap];
	}
    
	
	lotation = heading.trueHeading;
	// Update the graph with the new magnetic reading.
    //	[graphView updateHistoryWithX:heading.x y:heading.y z:heading.z];
}

@end
