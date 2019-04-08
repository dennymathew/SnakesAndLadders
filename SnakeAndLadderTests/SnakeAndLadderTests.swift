//
//  SnakeAndLadderTests.swift
//  SnakeAndLadderTests
//
//  Created by Denny Mathew on 08/04/19.
//  Copyright © 2019 Densigns. All rights reserved.
//

import XCTest
@testable import SnakeAndLadder

class SnakeAndLadderTests: XCTestCase {

    var gameClass = GameScene()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testPosition1() {
        let position = gameClass.calculateMovePosition(1)
        XCTAssertEqual(position, CGPoint(x: 1, y: 1))
    }
    
    func testPosition5() {
        let position = gameClass.calculateMovePosition(5)
        XCTAssertEqual(position, CGPoint(x: 1, y: 5))
    }
    
    func testPosition19() {
        let position = gameClass.calculateMovePosition(19)
        XCTAssertEqual(position, CGPoint(x: 2, y: 2))
    }
    
    func testPosition47() {
        let position = gameClass.calculateMovePosition(47)
        XCTAssertEqual(position, CGPoint(x: 5, y: 7))
    }
    
    func testPosition10() {
        let position = gameClass.calculateMovePosition(10)
        XCTAssertEqual(position, CGPoint(x: 1, y: 10))
    }
    
    func testPosition100() {
        let position = gameClass.calculateMovePosition(100)
        XCTAssertEqual(position, CGPoint(x: 10, y: 1))
    }
}
