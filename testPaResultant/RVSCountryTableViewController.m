//
//  UITableViewController+RVSCountryTableViewController.m
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "RVSCountryTableViewController.h"
#import "RVSTableViewHeaderView.h"
#import "RVSJsonLoader.h"
#import "RVSCountry.h"
#import "RVSCity.h"
#import "CityLocal+CoreDataClass.h"
#import "RVSSharedManager.h"

#define kSectionHeaderHeight            40.0
#define kCellHeight                     30.0
#define kCellID                         @"Cell"
#define kSectionHeaderID                @"SectionHeader"

@interface RVSCountryTableViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;
@property (assign, nonatomic) BOOL rightBarButtonExpandAllFlag;

@end

@implementation RVSCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RVSJsonLoader sharedManager] getAllTheData];
    self.countries = [RVSJsonLoader sharedManager].countries;
    self.cities = [RVSJsonLoader sharedManager].cities;
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < [self.countries count]; i++) {
        RVSCountry* country = [self.countries objectAtIndex:i];
        NSMutableArray *cells = [NSMutableArray array];
        for (int j = 0; j < [self.cities count]; j++) {
            RVSCity* city = [self.cities objectAtIndex:j];
            if (country.identifier == city.countryId) {
                [cells addObject:city];
            }
        }
        
        MGCollapsableTableViewSectionSource *section = [[MGCollapsableTableViewSectionSource alloc] initWithSectionInfo:country.name rows:cells];
        [dataSource addObject:section];
    }
    
    self.sections = dataSource;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kSectionHeaderID];
    
    [self collapseAllSections];
    _rightBarButtonExpandAllFlag=true;
    
    [self refreshRightBarButtonText];
}

- (IBAction)rightButtonClick:(id)sender {
    if (_rightBarButtonExpandAllFlag) {
        [self expandAllSections];
    } else {
        [self collapseAllSections];
    }
    _rightBarButtonExpandAllFlag = !_rightBarButtonExpandAllFlag;
    [self refreshRightBarButtonText];
}

- (void)refreshRightBarButtonText {
    [_rightBarButton setTitle:_rightBarButtonExpandAllFlag ? @"Expand All" : @"Collapse All"];
}

#pragma mark -
#pragma mark UITableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSectionHeaderHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    RVSCity* city = [self.sections[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    UIButton *starBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 50)];
    [starBtn setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    starBtn.tag = city.identifier;
    cell.accessoryView = starBtn;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RVSTableViewHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kSectionHeaderID];
    
    [self setupCollapsableSection:headerView sectionIndex:section];
    
    MGCollapsableTableViewSectionSource *sectionSource = self.sections[section];
    
    headerView.headerTextLabel.text = sectionSource.sectionInfo;
    headerView.tableViewSectionCollapsed = sectionSource.collapsed;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

#pragma mark - Actions

-(IBAction)btnClicked: (id)sender{
    UIButton *clicked = (UIButton *) sender;
    
    NSArray* allObjects = [self allObjects];
    
    BOOL addInFavourity = true;
    
    for (CityLocal* cityLocal in allObjects) {
        if ([cityLocal.identifier integerValue]==clicked.tag) {
            addInFavourity=false;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cityLocal.name message:@"Successfully Deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [[[RVSSharedManager sharedManager] managedObjectContext] deleteObject:cityLocal];
            [[[RVSSharedManager sharedManager] managedObjectContext] save:nil];
            [alert show];
        }
    }
    
    if (addInFavourity) {
        for (int i = 0; i < [self.cities count]; i++) {
            RVSCity* city = [self.cities objectAtIndex:i];
            if (city.identifier == clicked.tag) {
                CityLocal* cityLocal = [NSEntityDescription insertNewObjectForEntityForName:@"CityLocal" inManagedObjectContext:[RVSSharedManager sharedManager].       managedObjectContext];
                cityLocal.name = city.name;
                cityLocal.identifier = [NSNumber numberWithInt:city.identifier];
                cityLocal.idCountry = [NSNumber numberWithInt:city.countryId];
                NSError* error = nil;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cityLocal.name message:@"Successfully Added" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                if (![[[RVSSharedManager sharedManager] managedObjectContext] save:&error]) {
                    NSLog(@"%@", [error localizedDescription]);
                }
                [alert show];
            }
        }
    }
}

#pragma mark - myMethods

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"CityLocal"
                inManagedObjectContext:[[RVSSharedManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [[[RVSSharedManager sharedManager] managedObjectContext] executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}


@end
