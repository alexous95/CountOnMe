//
//  RecognizerTestClass.swift
//  CountOnMeTests
//
//  Created by Alexandre Goncalves on 16/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestClass: XCTestCase {
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    func testGivenEmptyElements_WhenStringAdded_ThenElementNotEmpty() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.elements.isEmpty)
    }
    
    func testGivenExpression_WhenExpressionGreaterOrEqualTo3_ThenExpressionIsTrue() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
    }
    
    func testGivenExpression_WhenExpressionLessThan3_ThenExpressionIsFalse() {
        let testString = "1 +"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }
    
    func testGivenStringOne_WhenAddingOperator_ThenExpressionIsOnePlus() {
        let testString = "1"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertTrue(calculator.canAddOperator)
    }
    
    func testGivenOnePlusOneEqual_WhenChekingEqualOperator_ThenResultIsTrue() {
        let testString = "1 + 1 ="
        
        XCTAssertTrue(calculator.expressionHaveResult(text: testString))
    }
    
    func testGivenString_WhenLastElementIsNotPlusOrMinus_ThenElementIsValid() {
        let testString: String = "4 + 2"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testGivenString_WhenLastElementIsPlus_thenElementIsNotValid() {
        let testString: String = "4 + 3 +"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    func testGivenString_WhenLastElementIsMinus_thenElementIsNotValid() {
        let testString: String = "4 + 3 -"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    func testGivenString_WhenLastElementIsMultiply_thenElementIsNotValid() {
        let testString: String = "4 + 3 *"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    func testGivenString_WhenLastElementIsDivide_thenElementIsNotValid() {
        let testString: String = "4 + 3 /"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    func testGivenExpressionIs2minus2_WhenSubstractingNumbers_ThenResultIs0() {
        let testString: String = "2 - 2"
        
        calculator.fillElementWith(text: testString)
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "0.0")
    }
    
    func testGivenExpressionIs2Plus2Plus2_WhenAddingNumbers_ThenResultIs6() {
        let testString: String = "2 + 2 + 2"
        
        calculator.fillElementWith(text: testString)
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "6.0")
    }
    
    func testGivenExpression2Times2_WhenMultipliyingNumber_ThenResultIs4() {
        let testString: String = "2 * 2"
        
        calculator.fillElementWith(text: testString)
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "4.0")
    }
    
    func testGivenExpression2Plus2Time3_WhenCheckingPriority_ThenResultIsTrue3() {
        let testString = "2 + 2 * 3"
        
        calculator.fillElementWith(text: testString)
        
        XCTAssert(calculator.expressionPriority() == (3, true))
    }
    
    func testGivenExpression2Plus4Times4Plus3_WhenCalculating_ThenResultIs21() {
        let testString: String = "2 + 4 * 4 + 3"
        
        calculator.fillElementWith(text: testString)
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "21.0")
    }
    
    func testGivenExpression2Divided0_WhenCalculating_ThenResultIsNotANumber() {
        let testString = "2 / 0"
        
        calculator.fillElementWith(text: testString)
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "Not a number")
    }
    
    func testGivenExpression2Plus2_WhenDeletingLastElement_ThenResulIs2Plus() {
        let testString = "2 - 2"
        
        calculator.fillElementWith(text: testString)
        calculator.deleteLastElement()
        
        XCTAssert(calculator.elements == ["2", "-"])
    }
    
    func testGivenExpression2Plus2_WhenDeletingAndAdding4_ThenResultIs2Plus4() {
        let testString = "2 + 2"
        
        calculator.fillElementWith(text: testString)
        calculator.deleteLastElement()
        calculator.elements.append("4")
        XCTAssert(calculator.elements == ["2", "+", "4"])
    }
    
    func testGivenExpression2Plus2_WhenDeletingAllElement_ThenResulIsEmpty() {
        let testString = "2 + 2"
        
        calculator.fillElementWith(text: testString)
        calculator.deleteAllElements()
        
        XCTAssert(calculator.elements.isEmpty)
    }
    
    func testGivenExpression2DividedBy0_WhenCalculating_ThenResultIsNotANumber() {
        let testString = "2 / 0"
        
        calculator.fillElementWith(text: testString)
        
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "Not a number")
    }
    
    func testGivenExpression2DividedBy2_WhenCalculating_ThenResultIsOne() {
        let testString = "2 / 2"
        
        calculator.fillElementWith(text: testString)
        
        calculator.performOperation()
        
        XCTAssert(calculator.elements[0] == "1.0")
    }
}
