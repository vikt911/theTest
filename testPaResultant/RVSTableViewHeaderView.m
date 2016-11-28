//
//  Style1TableViewHeaderView.m
//  MGCollapsableTableView
//
//  Created by Mgen on 15/11/10.
//  Copyright © 2015 Mgen. All rights reserved.
//  https://github.com/mgenware/MGCollapsableTableView
//

#import "RVSTableViewHeaderView.h"

@interface RVSTableViewHeaderView ()

@property (strong, nonatomic) IBOutlet UILabel *indicatorLabel;

@end

@implementation RVSTableViewHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)];
    [self addGestureRecognizer:tapGesture];
}

- (IBAction)contentViewClick:(id)sender {
    [self toggleState];
}

- (void)toggleState {
    self.tableViewSectionCollapsed = !self.tableViewSectionCollapsed;
    [self notifyDelegate];
}

- (void)setTableViewSectionCollapsed:(BOOL)tableViewSectionCollapsed {
    _tableViewSectionCollapsed = tableViewSectionCollapsed;
    [self refreshIndicator];
}

- (void)refreshIndicator {
    self.indicatorLabel.text = self.tableViewSectionCollapsed ? @"+" : @"-";
}

- (void)notifyDelegate {
    if ([self.delegate respondsToSelector:@selector(collapseableSection:isCollapsed:)]) {
        [self.delegate collapseableSection:self isCollapsed:self.tableViewSectionCollapsed];
    }
}

@end
