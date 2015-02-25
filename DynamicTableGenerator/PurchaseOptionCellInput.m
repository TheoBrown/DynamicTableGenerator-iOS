//
//  PurchaseOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 2/24/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "PurchaseOptionCellInput.h"

@implementation PurchaseOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_PurchaseCell;
}
-(id) initPurchaseCellwithProduct:(SKProduct*)product andDelegate:(id) delegate withTitle:(NSString*) cellTitle inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        self = [self initType:self.cellType forReturnKey:nil withTitle:cellTitle inSection:newSectionHeader];
        self.IAPproduct=product;
        self.SKDelegate=delegate;
    }
    return self;
}
-(NSString*) displayPrice {
    NSNumberFormatter * _priceFormatter;
    
    // Add to end of viewDidLoad
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_priceFormatter setLocale:self.IAPproduct.priceLocale];
    return [_priceFormatter stringFromNumber:self.IAPproduct.price];
}

#pragma mark - editable table cell delegate methods
-(void) cellPurchaseButtonPressed:(NSIndexPath *)indexPath {
    
    NSLog(@"Buying %@...", self.IAPproduct.productIdentifier);
    if ([self.SKDelegate respondsToSelector:@selector(buyProduct:)]){
        [self.SKDelegate performSelectorOnMainThread:@selector(buyProduct:) withObject:self.IAPproduct waitUntilDone:YES];
//         buyProduct:self.IAPproduct];
    }

}

@end
