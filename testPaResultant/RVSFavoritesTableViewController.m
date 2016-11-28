//
//  RVSTableViewController+RVSStudentsTableViewController.m
//  assignment_41-44
//
//  Created by vikt911 on 12.08.16.
//  Copyright © 2016 vikt911. All rights reserved.
//

#import "RVSFavoritesTableViewController.h"
#import "CityLocal+CoreDataClass.h"

@implementation RVSFavoritesTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"CityLocal"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    NSSortDescriptor* name = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[name]];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:self.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CityLocal* cityLocal = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [super configureCell:cell atIndexPath:indexPath];
    
    cell.textLabel.text = cityLocal.name;
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 50)];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_delete.png"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag = [cityLocal.identifier integerValue];
    cell.accessoryView = deleteBtn;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

-(IBAction)btnClicked: (id)sender{
    UIButton *clicked = (UIButton *) sender;
    
    NSArray* allObjects = [self allObjects];
    for (CityLocal* cityLocal in allObjects) {
        if ([cityLocal.identifier integerValue]==clicked.tag) {
            [self.managedObjectContext deleteObject:cityLocal];
            [self.managedObjectContext save:nil];
        }
    }
}

- (IBAction)btnAllClear:(id)sender {
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}

#pragma mark - myMethods

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"CityLocal"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

@end
