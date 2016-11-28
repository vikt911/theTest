//
//  CityLocal+CoreDataProperties.m
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "CityLocal+CoreDataProperties.h"

@implementation CityLocal (CoreDataProperties)

+ (NSFetchRequest<CityLocal *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CityLocal"];
}

@dynamic identifier;
@dynamic name;
@dynamic idCountry;

@end
