//
//  EMAPIClient.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "EMAPIClient.h"

static NSString * const earthquakeMonitorURLString = kBaseURLEarthquakeMonitor;

@implementation EMAPIClient

+ (EMAPIClient *)sharedClient
{
    static EMAPIClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:earthquakeMonitorURLString]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
//    if (self) {
//        self.responseSerializer = [AFJSONResponseSerializer serializer];
//        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        self.requestSerializer = [AFJSONRequestSerializer serializer];
//    }
    
    return self;
}

-(void)lastestEarthquakesRequestWithSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [self GET:@"all_hour.geojson" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
