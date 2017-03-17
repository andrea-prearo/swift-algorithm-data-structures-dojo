//
//  StackTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class StackTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0 ,8]
    lazy var stack: Stack<Int> = {
        return Stack<Int>(array: StackTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Stack<Int>().isEmpty)
        XCTAssertTrue(Stack<String>().isEmpty)
    }

    func testTop() {
        XCTAssertEqual(stack.top, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(stack.count, StackTests.integers.count)
        XCTAssertEqual(stack.array, StackTests.integers)
    }

    func testCount() {
        XCTAssertEqual(stack.count, StackTests.integers.count)
        XCTAssertEqual(Stack<Int>().count, 0)
        XCTAssertEqual(Stack(arrayLiteral: 1, 2, 3).count, 3)
    }

    func testPush() {
        let newValue = 1000
        do {
            try stack.push(newValue)
            XCTAssertEqual(stack.top, newValue)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testClear() {
        stack.clear()
        XCTAssertEqual(stack.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(stack.description, String(describing: StackTests.integers))
    }

    func testExpressibleByArrayLiteral() {
        let stack = Stack(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(stack.count, 4)
        XCTAssertEqual(stack.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(stack.array, StackTests.integers)
    }
}
