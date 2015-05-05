//
//  EMSharedConstants.h
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

//API
#define kBaseURLEarthquakeMonitor      @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/"

//Titles
#define kTitleHome                     @"Earthquake Monitor"
#define KTitleDetail                   @"Detail"
#define kTitleCode                     @"Colors Code"

//Fonts
#define FontHelvetica(s)              [UIFont fontWithName:@"Helvetica" size:s]
#define FontHelveticaNeue(s)          [UIFont fontWithName:@"Helvetica Neue" size:s]

//Colors
#define kLineSeparatorColor             [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0]
#define kHomeBackgroundColor            [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:17.0f/255.0f alpha:1.0]
#define kClearBlackColor                [UIColor colorWithRed:24.0f/255.0f green:23.0f/255.0f blue:30.0f/255.0f alpha:1.0]
#define kColorScale0                  [UIColor colorWithRed:0.0f/255.0f green:125.0f/255.0f blue:0.0f/255.0f alpha:1.0]
#define kColorScale1                  [UIColor colorWithRed:30.0f/255.0f green:200.0f/255.0f blue:30.0f/255.0f alpha:1.0]
#define kColorScale2                  [UIColor colorWithRed:182.0f/255.0f green:243.0f/255.0f blue:72.0f/255.0f alpha:1.0]
#define kColorScale3                  [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:30.0f/255.0f alpha:1.0]
#define kColorScale4                  [UIColor colorWithRed:230.0f/255.0f green:220.0f/255.0f blue:51.0f/255.0f alpha:1.0]
#define kColorScale5                  [UIColor colorWithRed:237.0f/255.0f green:199.0f/255.0f blue:68.0f/255.0f alpha:1.0]
#define kColorScale6                  [UIColor colorWithRed:244.0f/255.0f green:134.0f/255.0f blue:36.0f/255.0f alpha:1.0]
#define kColorScale7                  [UIColor colorWithRed:239.0f/255.0f green:96.0f/255.0f blue:48.0f/255.0f alpha:1.0]
#define kColorScale8                  [UIColor colorWithRed:200.0f/255.0f green:50.0f/255.0f blue:30.0f/255.0f alpha:1.0]
#define kColorScale9                  [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]

//UserDefaults
#define kCacheArray                     @"CacheArray"
#define kCacheLocation                  @"CacheLocation"
#define kCacheMagnitude                 @"CacheMagnitude"
#define kCacheLatitude                  @"CacheLatitude"
#define kCacheLongitude                 @"CacheLongitude"
#define kCacheDepth                     @"CacheDepth"
#define kCacheTime                      @"CacheTime"

//DDLog
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif