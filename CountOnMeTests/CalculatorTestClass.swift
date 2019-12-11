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
    
    func testGivenExpression1Plus_WhenAdding1_ThenExpressionIs1Plus1() {
        let testString = "1 +"
        
        calculator.fillElementWith(text: testString)
        calculator.addNumber("1")
        
        XCTAssert(calculator.elements == ["1", "+", "1"])
    }
    
    func testGivenExpression1_WhenAddingPlus_ThenExpressionIs1Plus() {
        let testString = "1"
        
        calculator.fillElementWith(text: testString)
        calculator.addOperator("+")
        
        XCTAssert(calculator.elements == ["1", "+"])
    }
    
    func testGivenNoExpression_WhenStartingWithMinus_ThenExpresionIsValid() {
        calculator.addOperator("-")
        
        XCTAssert(calculator.elements == ["-"])
    }
    
    func testGivenNoExpression_WhenStartingWithPlus_ThenExpresionIsNotValid() {
        calculator.addOperator("+")
        
        XCTAssert(calculator.elements == [])
    }
    
    func testGivenNoExpression_WhenStartingWithDot_ThenExpressionIsValid() {
        calculator.addDecimal(text: ".")
        
        XCTAssert(calculator.elements == ["."])
    }
    
    func testGivenExpressionIs1Plus_WhenAddingMinus5_ThenResultIs1PlusMinus5() {
        let testString = "1 +"
        
        calculator.fillElementWith(text: testString)
        calculator.addOperator("-")
        calculator.addNumber("5")
        
        XCTAssert(calculator.elements == ["1", "+", "-5"])
    }
    
    func testGivenNoExpression_WhenAddingMinus5PlusMinus5_ThenResultIsMinus5PlusMinus5() {
        
        calculator.addOperator("-")
        calculator.addNumber("5")
        calculator.addOperator("+")
        calculator.addOperator("-")
        calculator.addNumber("5")
        
        XCTAssert(calculator.elements == ["-5", "+", "-5"])
    }
    
    func testGivenExpression1Plus1Equal2_WhenAddingOperator_ThenExpressionIsReset() {
        let testString = "1 + 1 = 2"
        
        calculator.fillElementWith(text: testString)
        calculator.addOperator("+")
        
        XCTAssert(calculator.elements == [])
    }
    
    func testGivenExpression1Plus1Equal2_WhenAdding1_ThenExpressionIsReset() {
        let testString = "1 + 1 = 2"
        
        calculator.fillElementWith(text: testString)
        calculator.addNumber("1")
        
        XCTAssert(calculator.elements == [])
    }
    
    func testGivenExpression1Plus1Equal2_WhenAddingDot_ThenExpressionIsReset() {
        let testString = "1 + 1 = 2"
        
        calculator.fillElementWith(text: testString)
        calculator.addDecimal(text: ".")
        
        XCTAssert(calculator.elements == [])
    }
    
    func testGivenExpression1Plus1PointZeroFive_WhenAddingDot_ThenExpressionIsNotCorrect() {
        let testString = "1 + 1.05"
        
        calculator.fillElementWith(text: testString)
        calculator.addDecimal(text: ".")
        
        XCTAssert(calculator.elements == ["1", "+", "1.05"])
    }
    
    func testGivenExpression1Plus1_WhenAddingDot_ThenExpressionIs1Plus1Point() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        calculator.addDecimal(text: ".")
        
        XCTAssert(calculator.elements == ["1", "+", "1."])
    }
    
    func testGivenExpression1Plus1_WhenAddingEqual_ThenResultIs2() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        calculator.addEqual()
        
        XCTAssert(calculator.elements == ["2"])
    }
    
    func testGivenExpression1Plus_WhenAddingEqual_ThenResultIs1Plus() {
        let testString = "1 + "
        
        calculator.fillElementWith(text: testString)
        calculator.addEqual()
        
        XCTAssert(calculator.elements == ["1", "+"])
    }
    
    func testGivenExpression1_WhenAddingEqual_ThenResultIs1() {
        let testString = "1"
        
        calculator.fillElementWith(text: testString)
        calculator.addEqual()
        
        XCTAssert(calculator.elements == ["1"])
    }
    
    func testGivenExpression1Plus1_WhenDeletingLastElement_ThenExpressionIs1Plus() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        calculator.deleteLastElement()
        
        XCTAssert(calculator.elements == ["1", "+"])
    }
    
    func testGivenExpression1Plus1_WhenDeletingAllElement_ThenExpressionIsEmpty() {
        let testString = "1 + 1"
        
        calculator.fillElementWith(text: testString)
        calculator.deleteAllElements()
        
        XCTAssert(calculator.elements == [])
    }
}
