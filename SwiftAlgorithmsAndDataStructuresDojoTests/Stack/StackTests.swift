//
//  StackTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class StackTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var stack: Stack<Int> = {
        return Stack<Int>(array: StackTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Stack<Int>().isEmpty)
        XCTAssertTrue(Stack<String>().isEmpty)
    }

    func testPeek() {
        XCTAssertEqual(stack.peek, 8)
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
            XCTAssertEqual(stack.peek, newValue)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPop() {
        let maxIndex = StackTests.integers.count - 1
        _ = (0..<stack.count).map { XCTAssertEqual(stack.pop(), StackTests.integers[maxIndex - $0]) }
        XCTAssertNil(stack.pop())
    }

    func testClear() {
        stack.clear()
        XCTAssertEqual(stack.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(stack.description, String(describing: StackTests.integers))
    }

    func testSequence() {
        let maxIndex = StackTests.integers.count - 1
        var index = 0
        for item in stack {
            XCTAssertEqual(item, StackTests.integers[maxIndex - index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let stack = Stack(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(stack.count, 4)
        XCTAssertEqual(stack.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(stack.array, StackTests.integers)
    }

    func testOutOfSpaceError() {
        let maxSize = 10
        let stack = Stack<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? stack.push($0) }
        do {
            try stack.push(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, StackError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }
}
