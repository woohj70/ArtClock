//
//  CustomCompassView.h
//  ArtClock
//
//  Created by HYOUNG JUN WOO on 11. 3. 26..
//  Copyright 2011 com.mazdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import "CompassConfig.h"

@interface CustomCompassView : UIView<MKReverseGeocoderDelegate, MKMapViewDelegate, CLLocationManagerDelegate> {
    UIImageView *bgView;
    UIImageView *compassView;
    
    UILabel *dgreeLabel;
    UILabel *addrLabel;
    
    CLLocationManager *locManager;
    CLLocationCoordinate2D shareLoc;
    MKReverseGeocoder *reversGeo;
    
    double latitude;
	double longitude;
    
    double lotation;

}

@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) UIImageView *compassView;
@property (nonatomic, retain) UILabel *dgreeLabel;
@property (nonatomic, retain) UILabel *addrLabel;

@property (nonatomic, retain) CLLocationManager *locManager;
@property (nonatomic, retain) MKReverseGeocoder *reversGeo;

- (void)resizeView:(CGRect)frame;
@end
