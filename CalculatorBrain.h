//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Mark A Stewart on 11/25/12.
//  Copyright (c) 2012 Mark A Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void) pushOperand: (double) operand;
- (double) performOperation: (NSString *) operation;
- (void) clearModel;

@end
