//
//  MutableTableViewObjects.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "MutableTableViewObjects.h"

@implementation MutableTableViewObjects
//@synthesize startDate,endDate,yMaxValue, yMinValue, xValue, yValue ,majorIncrement ,minorIncrement, pickedUser, plotTypes ,resultsToPlot;
//@synthesize xNumber, yNumber;
@synthesize textInput;

- (id) init {
    self = [super init];
    if (self) {
        self.startDate = [[NSDate alloc] init];
        self.endDate = [[NSDate alloc] init];
        self.xNumber = [[NSNumber alloc] init];
        self.yNumber = [[NSNumber alloc] init];
        self.textInput = [[NSString alloc] init];
    }
    return self;
}
- (void) debugValues {
    NSLog(@" startDate : %@ \r\n endDate  %@ \r\n xVlue %@ \r\n yValue %@ \r\n text %@ ", self.startDate, self.endDate, self.xNumber, self.yNumber, self.textInput);
    
}
@end
