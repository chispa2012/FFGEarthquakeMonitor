//
//  NSDate+EMDateHelper.h
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>

//static NSString *SADateHelperFormatUTCDate = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
static NSString *EMDateHelperFormatDefaultDate = @"dd/MM/yyyy";
static NSString *EMDateHelperFormatDefaultTime = @"HH:mm:ss";
//static NSString *SADateHelperFormatHourMinTime = @"HH:mm";
static NSString *EMDateHelperFormatFull = @"dd/MM/yyyy HH:mm:ss";

@interface NSDate (EMDateHelper)

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

@end
