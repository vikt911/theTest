//
//  NSObject+RVSCity.m
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "RVSCity.h"

@implementation RVSCity

static const NSString* const_Id = @"Id";
static const NSString* const_Name = @"Name";
static const NSString* const_CountryId = @"CountryId";

- (id)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.identifier = [[responseObject objectForKey:const_Id] intValue];
        self.name = [responseObject objectForKey:const_Name];
        self.countryId = [[responseObject objectForKey:const_CountryId] intValue];
    }
    return self;
}

@end
