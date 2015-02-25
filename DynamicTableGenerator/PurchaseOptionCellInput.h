//
//  PurchaseOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 2/24/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"
#import <StoreKit/StoreKit.h>

@interface PurchaseOptionCellInput : BaseOptionCellInput
-(id) initPurchaseCellwithProduct:(SKProduct*)product andDelegate:(id) delegate withTitle:(NSString*) cellTitle inSection:(NSString*) newSectionHeader;

@property (strong, nonatomic) SKProduct* IAPproduct;

@property (strong, nonatomic) id SKDelegate;

-(NSString*) displayPrice;
@end
