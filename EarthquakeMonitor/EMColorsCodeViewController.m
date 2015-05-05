//
//  EMColorsCodeViewController.m
//  EarthquakeMonitor
//
//  Created by Fernando on 04/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "EMColorsCodeViewController.h"
#import "EMColorsCodeTableViewCell.h"
#import "UITableViewCell+EMdequeueCell.h"
#import "UIColor+EMScales.h"
#import "NSString+EMRanges.h"

@interface EMColorsCodeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;

@end

@implementation EMColorsCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = kTitleCode;
    self.view.backgroundColor = kHomeBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMColorsCodeTableViewCell *cell = [EMColorsCodeTableViewCell dequeueNibCellForTableView:tableView atIndexPath:indexPath];
    
    //DEScription
    cell.lbDescription.text = [NSString stringWithFormat:@"Magnitude: %@", [NSString rangeFromMagnitude:indexPath.row]];
    cell.lbDescription.textColor = [UIColor whiteColor];
    cell.lbDescription.font = FontHelveticaNeue(18);
    
    //Background Color
    cell.backgroundColor = [UIColor colorFromMagnitude:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];

    //Separator
    cell.separatorLine.backgroundColor = kLineSeparatorColor;
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

@end
