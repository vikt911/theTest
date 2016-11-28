//
//  NSObject+RVSCity.h
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVSCity : NSObject

@property (assign,nonatomic) NSInteger identifier;
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger countryId;

- (id)initWithDictionary:(NSDictionary *) responseObject;

@end
