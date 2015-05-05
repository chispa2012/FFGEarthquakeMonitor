//
//  EMCustomAnnotation.h
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface EMCustomAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *magnitude;

- (id)initWithLocation:(CLLocationCoordinate2D)coord magnitude:(NSString*)magnitude;

@end