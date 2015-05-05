//
//  NSString+EMRanges.m
//  EarthquakeMonitor
//
//  Created by Fernando on 04/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "NSString+EMRanges.h"

@implementation NSString (EMRanges)

+ (UIColor *)rangeFromMagnitude:(NSInteger)magnitude
{
    NSDictionary *scaleColors =  @{@"0" : @"0.0 - 0.9",
                                   @"1" : @"1.0 - 1.9",
                                   @"2" : @"2.0 - 2.9",
                                   @"3" : @"3.0 - 3.9",
                                   @"4" : @"4.0 - 4.9",
                                   @"5" : @"5.0 - 5.9",
                                   @"6" : @"6.0 - 6.9",
                                   @"7" : @"7.0 - 7.9",
                                   @"8" : @"8.0 - 8.9",
                                   @"9" : @"9.0 - 9.9",};
    return [scaleColors objectForKey:[NSString stringWithFormat:@"%ld", (long)magnitude]];
}

@end
