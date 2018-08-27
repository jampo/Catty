/**
 *  Copyright (C) 2010-2018 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "Pocket_Code-Swift.h"
#import <XCTest/XCTest.h>
#import "Formula.h"
#import "FormulaElement.h"
#import "InternToken.h"
#import "Operators.h"
#import "InternFormulaParser.h"
#import "Pocket_Code-Swift.h"

@interface FormulaElementIdempotenceTest : XCTestCase

@end

@implementation FormulaElementIdempotenceTest

- (void)testSingleNumber
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"1"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertTrue([formulaElement isIdempotent], @"FormulaElement should be idempotent");
}

- (void)testAddition
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"1"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:PLUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];

    XCTAssertTrue([formulaElement isIdempotent], @"FormulaElement should be idempotent");
}

- (void)testMultiplication
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"1"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:MULT]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_BRACKET_OPEN]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:MINUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"5"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_BRACKET_CLOSE]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertTrue([formulaElement isIdempotent], @"FormulaElement should be idempotent");
}

- (void)testSingleSensor
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationXSensor.tag]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testTwoSensor
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationXSensor.tag]];
        [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:PLUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationYSensor.tag]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testSensorLeftChild
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationXSensor.tag]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:PLUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testSensorRightChild
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:PLUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationXSensor.tag]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testNestedSensorRightChild
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:PLUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"4"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:MINUS]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_SENSOR AndValue:AccelerationXSensor.tag]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testSingleNonIdempotentFunction
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_NAME AndValue:@"RAND"]];  // TODO use Function property
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_PARAMETERS_BRACKET_OPEN]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"3"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_PARAMETER_DELIMITER]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"4"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_PARAMETERS_BRACKET_CLOSE]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testSingleFunctionSin
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_NAME AndValue:@"SIN"]]; // TODO use Function property
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_PARAMETERS_BRACKET_OPEN]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"90"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_FUNCTION_PARAMETERS_BRACKET_CLOSE]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertTrue([formulaElement isIdempotent], @"FormulaElement should be idempotent");
}

- (void)testSingleUserVariable
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_USER_VARIABLE AndValue:@"test"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testUserVariableAndNumber
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_NUMBER AndValue:@"2"]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_OPERATOR AndValue:[Operators getName:MULT]]];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_USER_VARIABLE AndValue:@"test"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

- (void)testSingleString
{
    NSMutableArray *internTokenList = [[NSMutableArray alloc] init];
    [internTokenList addObject:[[InternToken alloc] initWithType:TOKEN_TYPE_STRING AndValue:@"test"]];
    
    InternFormulaParser *internParser = [[InternFormulaParser alloc] initWithTokens:internTokenList];
    FormulaElement *formulaElement = [internParser parseFormulaForSpriteObject:nil];
    
    XCTAssertFalse([formulaElement isIdempotent], @"FormulaElement should not be idempotent");
}

@end
