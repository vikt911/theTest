//
//  NSObject+RVSCountry.h
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVSCountry : NSObject

@property (assign,nonatomic) NSInteger identifier;
@property (strong,nonatomic) NSString* name;

- (id)initWithDictionary:(NSDictionary *) responseObject;

@end
