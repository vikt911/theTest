//
//  CityLocal+CoreDataProperties.h
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "CityLocal+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CityLocal (CoreDataProperties)

+ (NSFetchRequest<CityLocal *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *identifier;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *idCountry;

@end

NS_ASSUME_NONNULL_END
