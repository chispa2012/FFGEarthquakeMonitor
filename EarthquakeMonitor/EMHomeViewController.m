//
//  EMHomeViewController.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "EMHomeViewController.h"
#import "EMAPIClient.h"
#import "EMHomeTableViewCell.h"
#import "UITableViewCell+EMdequeueCell.h"
#import "NSDate+EMDateHelper.h"
#import "EMEarthquakeDetailViewController.h"
#import "UIColor+EMScales.h"
#import "EMColorsCodeViewController.h"

@interface EMHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end


@implementation EMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = kTitleHome;
    self.view.backgroundColor = kHomeBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //InfoButton
    UIButton *btnInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [btnInfo addTarget:self action:@selector(tapInfo) forControlEvents:UIControlEventTouchUpInside];
    btnInfo.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *biRight = [[UIBarButtonItem alloc] initWithCustomView:btnInfo];
    self.navigationItem.rightBarButtonItem = biRight;
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor orangeColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(updateData)
                  forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:self.refreshControl];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.arrayData = [defaults objectForKey:kCacheArray];
    [self.table reloadData];

    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMHomeTableViewCell *cell = [EMHomeTableViewCell dequeueNibCellForTableView:tableView atIndexPath:indexPath];
    NSDictionary *dic = [self.arrayData objectAtIndex:indexPath.row];
    
    //Ubicación
    NSString *location = [dic objectForKey:kCacheLocation];//[[dic objectForKey:@"properties"] objectForKey:@"place"];
    
    //Magnitude
    NSNumber *magnitude = [dic objectForKey:kCacheMagnitude];//[[dic objectForKey:@"properties"] objectForKey:@"mag"];
    
    //Descripción
    //First row
    NSMutableAttributedString *firsAtt = [[NSMutableAttributedString alloc]initWithString:location];
    [firsAtt addAttribute:NSFontAttributeName value:FontHelvetica(18) range:NSMakeRange(0, [location length])];
    [firsAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [location length])];
    //Second row
    NSString *secondRow = [NSString stringWithFormat:@"\nMagnitude: %.02f", [magnitude floatValue]];
    NSMutableAttributedString *secondAtt = [[NSMutableAttributedString alloc]initWithString:secondRow];
    [secondAtt addAttribute:NSFontAttributeName value:FontHelveticaNeue(15) range:NSMakeRange(0, [secondRow length])];
    [secondAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [secondRow length])];
    
    //Final attributed string
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:firsAtt];
    [attString appendAttributedString:secondAtt];
    cell.lbDescription.attributedText = attString;
    
    //Background
    cell.backgroundColor = [UIColor colorFromMagnitude:[NSString stringWithFormat:@"%@", magnitude]];
    
    //Separator
    cell.separatorLine.backgroundColor = kLineSeparatorColor;
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.arrayData objectAtIndex:indexPath.row];
    EMEarthquakeDetailViewController *detailVC = [[EMEarthquakeDetailViewController alloc]initWithInfo:dic];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Local Actions

-(void)updateData
{
    [[EMAPIClient sharedClient] lastestEarthquakesRequestWithSuccess:^(id responseObject) {
        DLog(@"responseObject:%@", responseObject);
        NSDictionary *resposnseDic = (NSDictionary*)responseObject;
        self.arrayData = [resposnseDic objectForKey:@"features"];
        
        //Store in user defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arrayEartquakes = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in self.arrayData) {
            NSString *location = [[dic objectForKey:@"properties"] objectForKey:@"place"];
            NSNumber *magnitude = [[dic objectForKey:@"properties"] objectForKey:@"mag"];
            NSArray *coordinates = [[dic objectForKey:@"geometry"] objectForKey:@"coordinates"];
            NSNumber *latitude = [coordinates objectAtIndex:1];
            NSNumber *longitude = [coordinates objectAtIndex:0];
            NSNumber *depth = [coordinates objectAtIndex:2];
            NSString *time =  [[dic objectForKey:@"properties"] objectForKey:@"time"];
            
            NSDictionary *cacheDic = @{kCacheLocation   : location,
                                       kCacheMagnitude  : magnitude,
                                       kCacheLatitude   : latitude,
                                       kCacheLongitude  : longitude,
                                       kCacheDepth      : depth,
                                       kCacheTime       : time};
            [arrayEartquakes addObject:cacheDic];
        }
        [defaults setObject:arrayEartquakes forKey:kCacheArray];
        [defaults synchronize];
        
        self.arrayData = arrayEartquakes;
        [self.table reloadData];
        [self.refreshControl endRefreshing];
        [self getLastUpdate];
        
    } failure:^(NSError *error) {
        DLog(@"error:%@", error);
        [self.refreshControl endRefreshing];
    }];
}

-(void)getLastUpdate
{
    NSString *title = [NSString stringWithFormat:@"Last update: %@", [NSDate stringFromDate:[NSDate date] withFormat:EMDateHelperFormatFull]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
}

-(void)tapInfo
{
    EMColorsCodeViewController *colorsCodeVC = [[EMColorsCodeViewController alloc]init];
    [self.navigationController pushViewController:colorsCodeVC animated:YES];
}

@end
