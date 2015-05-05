//
//  NSDate+EMDateHelper.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "NSDate+EMDateHelper.h"

@implementation NSDate (EMDateHelper)

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSLocale *enUSPOSIXLocale;
    enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    //    [dateFormatter setTimeZone:timeZone];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

@end
