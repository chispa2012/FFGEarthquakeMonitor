//
//  EMEarthquakeDetailViewController.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "EMEarthquakeDetailViewController.h"
#import <MapKit/MapKit.h>
#import "EMCustomAnnotation.h"
#import "NSDate+EMDateHelper.h"
#import "UIColor+EMScales.h"

@interface EMEarthquakeDetailViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *lbDescription;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSDictionary *earthquakeDic;

@end

@implementation EMEarthquakeDetailViewController

-(id)initWithInfo:(NSDictionary*)info
{
    self = [super init];
    if (self) {
        self.earthquakeDic = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kHomeBackgroundColor;
    self.title = KTitleDetail;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //MapView
    double latitude = [[self.earthquakeDic objectForKey:kCacheLatitude] doubleValue];
    double longitude = [[self.earthquakeDic objectForKey:kCacheLongitude] doubleValue];
    CLLocationCoordinate2D newCoord = CLLocationCoordinate2DMake(latitude, longitude);
    //Magnitude
    NSNumber *magnitude = [self.earthquakeDic objectForKey:kCacheMagnitude];//[[self.earthquakeDic objectForKey:@"properties"] objectForKey:@"mag"];
    EMCustomAnnotation *annotation = [[EMCustomAnnotation alloc] initWithLocation:newCoord magnitude:[NSString stringWithFormat:@"%.02f", [magnitude floatValue]]];
    
    self.mapView.delegate = self;
    [self.mapView addAnnotation:annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newCoord, 500000, 500000);
    [self.mapView setRegion:region animated:YES];
    
    //Description
    [self setUpDescription];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapView Protocol

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id) annotation
{
    EMCustomAnnotation *customAnnotation = (EMCustomAnnotation*)annotation;
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    MKAnnotationView *aView = [[MKAnnotationView alloc] initWithAnnotation:customAnnotation reuseIdentifier:@"pinView"];
    aView.canShowCallout = NO;
    aView.enabled = YES;
    aView.draggable = YES;
    
    //Circular view
    aView.backgroundColor = [UIColor clearColor];
    UILabel *circleView = (UILabel*)[aView viewWithTag:100];
    if (!circleView) {
        circleView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,50,50)];
        circleView.alpha = 0.9;
        circleView.layer.cornerRadius = 25;
        circleView.layer.masksToBounds = YES;
        circleView.tag = 100;
        circleView.textAlignment = NSTextAlignmentCenter;
        circleView.textColor = [UIColor whiteColor];
        circleView.font = FontHelveticaNeue(22);
        [aView addSubview:circleView];
    }
    NSString *magnitude = [NSString stringWithFormat:@"%.02f", [customAnnotation.magnitude floatValue]];
    circleView.text = magnitude;
    circleView.backgroundColor = [UIColor colorFromMagnitude:magnitude];
    
    CGRect frame = aView.frame;
    frame.size.width = 50;
    frame.size.height = 50;
    aView.frame = frame;
    
    return aView;
}

#pragma mark - Local Actions

-(void)setUpDescription
{
    self.lbDescription.backgroundColor = [UIColor clearColor];
    self.lbDescription.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(tapEvent)];
    [self.lbDescription addGestureRecognizer:singleFingerTap];
    
    //Location
    NSString *location = [self.earthquakeDic objectForKey:kCacheLocation];
    //Magnitude
    NSNumber *magnitude = [self.earthquakeDic objectForKey:kCacheMagnitude];
    //Date and Time
    NSString *strInterval = [self.earthquakeDic objectForKey:kCacheTime];
    NSTimeInterval interval = [strInterval doubleValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *strDate = [NSDate stringFromDate:date withFormat:EMDateHelperFormatDefaultDate];
    NSString *strTime = [NSDate stringFromDate:date withFormat:EMDateHelperFormatDefaultTime];
    NSString *strDateTime = [NSString stringWithFormat:@"%@ at %@", strDate, strTime];
    
    //Depth
    double depth = [[self.earthquakeDic objectForKey:kCacheDepth] doubleValue];
    NSString *strDepth = [NSString stringWithFormat:@"Depth: %.02f Km", depth];
    
    //First row
    NSString *firstRow = [NSString stringWithFormat:@"Magnitude: %.02f", [magnitude floatValue]];
    NSMutableAttributedString *firsAtt = [[NSMutableAttributedString alloc]initWithString:firstRow];
    [firsAtt addAttribute:NSFontAttributeName value:FontHelvetica(20) range:NSMakeRange(0, [firstRow length])];
    [firsAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [firstRow length])];
    //Second row
    NSString *secondRow = [NSString stringWithFormat:@"\n%@", strDateTime];
    NSMutableAttributedString *secondAtt = [[NSMutableAttributedString alloc]initWithString:secondRow];
    [secondAtt addAttribute:NSFontAttributeName value:FontHelvetica(20) range:NSMakeRange(0, [secondRow length])];
    [secondAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [secondRow length])];
    //Third row
    NSString *thirdRow = [NSString stringWithFormat:@"\n\n%@\n%@", location, strDepth];
    NSMutableAttributedString *thirdAtt = [[NSMutableAttributedString alloc]initWithString:thirdRow];
    [thirdAtt addAttribute:NSFontAttributeName value:FontHelveticaNeue(17) range:NSMakeRange(0, [thirdRow length])];
    [thirdAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [thirdRow length])];
    
    //Final attributed string
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:firsAtt];
    [attString appendAttributedString:secondAtt];
    [attString appendAttributedString:thirdAtt];
    self.lbDescription.attributedText = attString;
}

-(void)tapEvent
{
    double latitude = [[self.earthquakeDic objectForKey:kCacheLatitude] doubleValue];
    double longitude = [[self.earthquakeDic objectForKey:kCacheLongitude] doubleValue];
    CLLocationCoordinate2D newCoord = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newCoord, 500000, 500000);
    [self.mapView setRegion:region animated:YES];
}

@end
