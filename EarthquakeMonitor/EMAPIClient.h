//
//  EMAPIClient.h
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface EMAPIClient : AFHTTPSessionManager

+ (EMAPIClient *)sharedClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

-(void)lastestEarthquakesRequestWithSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


@end
