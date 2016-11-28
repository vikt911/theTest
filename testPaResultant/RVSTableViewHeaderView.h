//
//  Style1TableViewHeaderView.h
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import <UIKit/UIKit.h>
#import "MGCollapsableTableViewSectionViewBase.h"

@interface RVSTableViewHeaderView : UITableViewHeaderFooterView<MGCollapsableTableViewSectionViewBase>

@property (nonatomic, weak) id<MGCollapsableTableViewSectionViewBaseDelegate> delegate;
@property (nonatomic, assign) BOOL tableViewSectionCollapsed;

@property (strong, nonatomic) IBOutlet UILabel *headerTextLabel;

@end
