//
//  NSObject+RVSJsonLoader.h
//  testPaResultant
//
//  Created by vikt911 on 28.11.16.
//  Copyright © 2016 RVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVSJsonLoader : NSObject

@property (strong,nonatomic) NSArray* countries;
@property (strong,nonatomic) NSArray* cities;

+ (RVSJsonLoader *)sharedManager;

- (void) getAllTheData;

@end
