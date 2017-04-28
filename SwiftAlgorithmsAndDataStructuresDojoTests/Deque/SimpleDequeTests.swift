//
//  SimpleDequeTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Andrea Prearo on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class SimpleDequeTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var deque: SimpleDeque<Int> = {
        return SimpleDeque<Int>(array: SimpleDequeTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(SimpleDeque<Int>().isEmpty)
        XCTAssertTrue(SimpleDeque<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(deque.front, 5)
    }

    func testBack() {
        XCTAssertEqual(deque.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(deque.count, SimpleDequeTests.integers.count)
        XCTAssertEqual(deque.array, SimpleDequeTests.integers)
    }

    func testCount() {
        XCTAssertEqual(deque.count, SimpleDequeTests.integers.count)
        XCTAssertEqual(SimpleDeque<Int>().count, 0)
        XCTAssertEqual(SimpleDeque(arrayLiteral: 1, 2, 3).count, 3)
    }

    func testPush() {
        let newValue = 1000
        do {
            try deque.push(newValue)
            XCTAssertEqual(deque.front, 5)
            XCTAssertEqual(deque.back, newValue)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPushFront() {
        let newValue = 1000
        do {
            try deque.pushFront(newValue)
            XCTAssertEqual(deque.front, newValue)
            XCTAssertEqual(deque.back, 8)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPop() {
        _ = (0..<deque.count).map { XCTAssertEqual(deque.pop(), SimpleDequeTests.integers[$0]) }
        XCTAssertNil(deque.pop())
    }

    func testPopBack() {
        let maxIndex = StackTests.integers.count - 1
        _ = (0..<deque.count).map { XCTAssertEqual(deque.popBack(), SimpleDequeTests.integers[maxIndex - $0]) }
        XCTAssertNil(deque.popBack())
    }

    func testClear() {
        deque.clear()
        XCTAssertEqual(deque.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(deque.description, String(describing: SimpleDequeTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in deque {
            XCTAssertEqual(item, SimpleDequeTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let deque = SimpleDeque(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(deque.count, 4)
        XCTAssertEqual(deque.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(deque.array, SimpleDequeTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let deque = SimpleDeque<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? deque.push($0) }
        do {
            try deque.push(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }

    func testPushFrontOutOfSpaceError() {
        let maxSize = 10
        let deque = SimpleDeque<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? deque.pushFront($0) }
        do {
            try deque.pushFront(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }
}
