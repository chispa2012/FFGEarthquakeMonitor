//
//  UITableViewCell+EMdequeueCell.h
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (EMdequeueCell)

+ (instancetype)dequeueNibCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
