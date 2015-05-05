//
//  NSString+EMRanges.h
//  EarthquakeMonitor
//
//  Created by Fernando on 04/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EMRanges)

+ (UIColor *)rangeFromMagnitude:(NSInteger)magnitude;

@end
