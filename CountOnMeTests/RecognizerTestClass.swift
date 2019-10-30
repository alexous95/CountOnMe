//
//  RecognizerTestClass.swift
//  CountOnMeTests
//
//  Created by Alexandre Goncalves on 16/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class RecognizerTestClass: XCTestCase {
  var reckon: Recognizer!
  
  override func setUp() {
    super.setUp()
    reckon = Recognizer()
  }
  
  func testGivenNullInstance_WhenInstanceCreated_ThenInstanceNotNull() {
    XCTAssertNotNil(reckon)
  }
  
  func testGivenEmptyElements_WhenStringAdded_ThenElementNotEmpty() {
    let testString = "1 + 1"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.elements.isEmpty)
  }
  
  func testGivenExpression_WhenExpressionGreaterOrEqualTo3_ThenExpressionIsTrue() {
    let testString = "1 + 1"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertTrue(reckon.expressionHaveEnoughElement)
  }
  
  func testGivenExpression_WhenExpressionLessThan3_ThenExpressionIsFalse() {
    let testString = "1 +"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionHaveEnoughElement)
  }
  
  func testGivenStringOne_WhenAddingOperator_ThenExpressionIsOnePlus() {
    let testString = "1"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertTrue(reckon.canAddOperator)
  }
  
  func testGivenOnePlusOneEqual_WhenChekingEqualOperator_ThenResultIsTrue() {
    let testString = "1 + 1 ="
    
    XCTAssertTrue(reckon.expressionHaveResult(text: testString))
  }
  
  func testGivenString_WhenLastElementIsNotPlusOrMinus_ThenElementIsValid() {
    let testString: String = "4 + 2"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertTrue(reckon.expressionIsCorrect)
  }
  
  func testGivenString_WhenLastElementIsPlus_thenElementIsNotValid() {
    let testString: String = "4 + 3 +"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionIsCorrect)
  }
  
  func testGivenString_WhenLastElementIsMinus_thenElementIsNotValid() {
    let testString: String = "4 + 3 -"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionIsCorrect)
  }
  
  func testGivenString_WhenLastElementIsMultiply_thenElementIsNotValid() {
    let testString: String = "4 + 3 *"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionIsCorrect)
  }
  
  func testGivenString_WhenLastElementIsDivide_thenElementIsNotValid() {
    let testString: String = "4 + 3 /"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionIsCorrect)
  }
  
  func testGivenExpressionIs2minus2_WhenSubstractingNumbers_ThenResultIs0() {
    let testString: String = "2 - 2"
    
    reckon.fillElementWith(text: testString)
    reckon.performOperation()
    
    XCTAssert(reckon.elements[0] == "0.0")
  }
  
  func testGivenExpressionIs2Plus2Plus2_WhenAddingNumbers_ThenResultIs6() {
    let testString: String = "2 + 2 + 2"
    
    reckon.fillElementWith(text: testString)
    reckon.performOperation()
    
    XCTAssert(reckon.elements[0] == "6.0")
  }
  
  func testGivenExpression2Times2_WhenMultipliyingNumber_ThenResultIs4() {
    let testString: String = "2 * 2"
    
    reckon.fillElementWith(text: testString)
    reckon.performOperation()
    
    XCTAssert(reckon.elements[0] == "4.0")
  }
  
  func testGivenExpression2Plus2Time3_WhenCheckingPriority_ThenResultIsTrue3() {
    let testString = "2 + 2 * 3"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssert(reckon.expressionPriority() == (3, true))
  }
  
  func testGivenExpression2Plus4Times4Plus3_WhenCalculating_ThenResultIs21() {
    let testString: String = "2 + 4 * 4 + 3"
    
    reckon.fillElementWith(text: testString)
    reckon.performOperation()
    
    XCTAssert(reckon.elements[0] == "21.0")
  }
  
}
