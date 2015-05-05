//
//  EMCustomAnnotation.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "EMCustomAnnotation.h"

@implementation EMCustomAnnotation

@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord magnitude:(NSString *)magnitude {
    self = [super init];
    if (self) {
        coordinate = coord;
        self.magnitude = magnitude;
    }
    return self;
}

@end