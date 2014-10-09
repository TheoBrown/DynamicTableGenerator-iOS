//
//  PropertyUtil.h
//  CoreDataTest
//
//  Created by Theodore Brown on 11/23/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertyUtil : NSObject

+ (NSDictionary *)classPropsFor:(Class)klass;

@end