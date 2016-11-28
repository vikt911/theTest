//
//  UITableViewController+RVSCountryTableViewController.h
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGCollapsableTableViewController.h"

@interface RVSCountryTableViewController : MGCollapsableTableViewController

@property (strong,nonatomic) NSArray* countries;
@property (strong,nonatomic) NSArray* cities;

@end
