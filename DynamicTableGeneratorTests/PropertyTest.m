//
//  PropertyTest.m
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 10/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "PropertyUtil.h"
#import "TestObject.h"

@interface PropertyTest : XCTestCase

@end

@implementation PropertyTest

- (void) testPropertyList {
//    PropertyUtil* pu = [[PropertyUtil alloc] init];
//    NSString *testString = [[NSString alloc] init];
    TestObject * object = [[TestObject alloc] init];
    NSDictionary *properties = [PropertyUtil classPropsFor:[object class]];
    NSLog(@"Properties for class %@", properties);
    XCTAssertNotNil(properties, @"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
