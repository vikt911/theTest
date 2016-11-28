//
//  NSObject+RVSCountry.m
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "RVSCountry.h"

@implementation RVSCountry

static const NSString* const_Id = @"Id";
static const NSString* const_Name = @"Name";

- (id)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.identifier = [[responseObject objectForKey:const_Id] intValue];
        self.name = [responseObject objectForKey:const_Name];
    }
    return self;
}

@end
