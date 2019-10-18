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
  
  func testGivenString_WhenLastElementIsNotPlusOrMinus_ThenElementIsValid() {
    let testString: String = "4 + 2"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertTrue(reckon.expressionIsCorrect)
  }
  
  func testGivenString_WhenLastElementIsPlusOrMinus_thenElementIsNotValid() {
    let testString: String = "4 + 3 +"
    
    reckon.fillElementWith(text: testString)
    
    XCTAssertFalse(reckon.expressionIsCorrect)
  }
  
}
