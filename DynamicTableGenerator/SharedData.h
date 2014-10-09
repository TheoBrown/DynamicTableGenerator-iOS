//
//  SharedData.h
//  CoreDataTest
//
//  Created by Theodore Brown on 10/14/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SharedData : NSObject {
    NSUserDefaults *settings;
}
@property(nonatomic,retain)    NSUserDefaults *settings;

+(SharedData*)getInstance;
@end  
