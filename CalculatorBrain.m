//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Mark A Stewart on 11/25/12.
//  Copyright (c) 2012 Mark A Stewart. All rights reserved.
//

#import "CalculatorBrain.h"
#import "math.h"

@interface CalculatorBrain ()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack=_operandStack;
#define    DEGREES_TO_RADIANS( d )            ((d) * 0.0174532925199432958)

- (NSMutableArray *) operandStack //Getter what syntehesize will gen.
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void) clearModel
{
   [self.operandStack removeAllObjects];
    return;

}

- (void) pushOperand: (double) operand
{
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double) performOperation: (NSString *) operation
{
    double result = 0;
    NSString *resultStr;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtraend = [self popOperand];
        result = [self popOperand] - subtraend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisend = [self popOperand];
        if (divisend) result = [self popOperand] / divisend;
    } else if ([operation isEqualToString:@"sqrt"]) {
        double sqrtarg = [self popOperand];
        if (sqrtarg) result = sqrt(sqrtarg);
    } else if ([operation isEqualToString:@"sin"]) {
        double degrees = [self popOperand];
        if (degrees) {
            resultStr = [NSString stringWithFormat:@"%.5f", sin(DEGREES_TO_RADIANS(degrees))];
            result = [resultStr doubleValue];
        }
    } else if ([operation isEqualToString:@"cos"]) {
        double degrees = [self popOperand];
        if (degrees) {
            resultStr = [NSString stringWithFormat:@"%.5f", cos(DEGREES_TO_RADIANS(degrees))];
            result = [resultStr doubleValue];
        }
    } else if ([operation isEqualToString:@"π"]) {
        result = (double) M_PI;
    }
    
    NSLog(@"performOperation result =%f", result);
    [self pushOperand:(double)result];
    
    return result;
}

@end
