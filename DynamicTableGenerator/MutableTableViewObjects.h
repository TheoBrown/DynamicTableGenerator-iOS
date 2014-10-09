//
//  MutableTableViewObjects.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutableTableViewObjects : NSObject

@property  NSDate *startDate;
@property (retain, atomic) NSDate *endDate;
@property (retain, atomic) NSNumber *yNumber;
@property (retain, atomic) NSNumber *xNumber;
@property (retain, atomic) NSString *textInput;

@property (retain, atomic) NSString *plotTypes;
@property (retain, atomic) NSArray *resultsToPlot;
@property (retain, atomic) NSObject *pickedUser;
@property (nonatomic) float yValue;// 0.040f
@property (nonatomic) float xValue;// 0.020f

@property (nonatomic) NSInteger majorIncrement;// 50
@property (nonatomic) NSInteger minorIncrement;// 10
@property (nonatomic) CGFloat yMaxValue; // 700
@property (nonatomic) CGFloat yMinValue; // 700

- (void) debugValues;
@end
