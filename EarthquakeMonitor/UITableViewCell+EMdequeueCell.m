//
//  UITableViewCell+EMdequeueCell.m
//  EarthquakeMonitor
//
//  Created by Fernando on 03/05/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

#import "UITableViewCell+EMdequeueCell.h"

@implementation UITableViewCell (EMdequeueCell)

+ (instancetype)dequeueNibCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([self class])];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

@end
