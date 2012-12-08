//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mark A Stewart on 11/23/12.
//  Copyright (c) 2012 Mark A Stewart. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMIddleofEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize EntryView = _EntryView;
@synthesize userIsInTheMIddleofEnteringANumber = _userIsInTheMIddleofEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)newbutton:(id)sender {
    NSString *digit = [sender currentTitle];
    
    if (self.userIsInTheMIddleofEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMIddleofEnteringANumber = YES;
    }
}

- (IBAction)decimalPressed:(UIButton *)sender {
    
    NSRange range = [self.display.text rangeOfString:@"."];
    if (self.userIsInTheMIddleofEnteringANumber)
    {
        if (range.location == NSNotFound) {
            self.display.text = [self.display.text stringByAppendingString:@"."];
        }
    } else  self.display.text = @".";
    self.userIsInTheMIddleofEnteringANumber = YES;
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.userIsInTheMIddleofEnteringANumber=NO;
    self.display.text = @" ";
    self.EntryView.text = @" ";
    [self.brain clearModel];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMIddleofEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.EntryView.text = [self.EntryView.text stringByReplacingOccurrencesOfString:@"="  withString:@""];
    NSString *finalString = [NSString stringWithFormat:@" %@ =", sender.currentTitle];
    self.EntryView.text = [self.EntryView.text stringByAppendingString:finalString];
}
- (IBAction)enterPressed {
    self.EntryView.text = [self.EntryView.text stringByReplacingOccurrencesOfString:@"="  withString:@""];
    if (self.userIsInTheMIddleofEnteringANumber) {
        NSString *finalString = [NSString stringWithFormat:@" %@ ", self.display.text];
        self.EntryView.text = [self.EntryView.text stringByAppendingString:finalString];
    }
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMIddleofEnteringANumber=NO;
}

- (IBAction)backspacePressed:(UIButton *)sender {
    NSString *currentDisplay = self.display.text;
    if ( [currentDisplay length] > 0)
            self.display.text = [currentDisplay substringToIndex:[currentDisplay length] - 1];
}

- (IBAction)changeSign:(UIButton *)sender {
    if (self.userIsInTheMIddleofEnteringANumber) {
        double result = [self.display.text doubleValue] * (-1);
        self.display.text = [NSString stringWithFormat:@"%g", result];
    }
}

@end
