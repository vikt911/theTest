//
//  NSObject+RVSJsonLoader.m
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import "RVSJsonLoader.h"
#import "RVSCountry.h"
#import "RVSCity.h"

@implementation RVSJsonLoader

+ (RVSJsonLoader *)sharedManager {
    
    static RVSJsonLoader* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[RVSJsonLoader alloc]init];
        
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) getAllTheData {
    
    NSString* pathJson = @"https://atw-backend.azurewebsites.net/api/countries";
    NSError* error = nil;
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:pathJson]];
    
    if (jsonData!=nil) {
    NSDictionary* jsonDataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

    NSMutableArray* tempCountries = [[NSMutableArray alloc] init];
    NSMutableArray* tempCities = [[NSMutableArray alloc] init];
    
    for(NSDictionary* dict in [jsonDataArray valueForKeyPath:@"Result"]) {
        
        RVSCountry* country = [[RVSCountry alloc] initWithDictionary:dict];
        [tempCountries addObject:country];
        
        for(NSDictionary* dictTwo in [dict valueForKeyPath:@"Cities"]) {
            
            RVSCity* city = [[RVSCity alloc] initWithDictionary:dictTwo];
            [tempCities addObject:city];
            
        }
    }
    
    self.countries = tempCountries;
    self.cities = tempCities;
    }
}

@end
