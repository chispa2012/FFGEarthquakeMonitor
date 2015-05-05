//
//  UIColor+EMScales.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "UIColor+EMScales.h"

@implementation UIColor (EMScales)

+ (UIColor *)colorFromMagnitude:(NSString *)magnitude
{
    NSDictionary *scaleColors =  @{@"0" : kColorScale0,
                                   @"1" : kColorScale1,
                                   @"2" : kColorScale2,
                                   @"3" : kColorScale3,
                                   @"4" : kColorScale4,
                                   @"5" : kColorScale5,
                                   @"6" : kColorScale6,
                                   @"7" : kColorScale7,
                                   @"8" : kColorScale8,
                                   @"9" : kColorScale9,};
    NSString *truncedStr = [magnitude substringToIndex:1];
    return [scaleColors objectForKey:[NSString stringWithFormat:@"%@", truncedStr]];
}


@end
