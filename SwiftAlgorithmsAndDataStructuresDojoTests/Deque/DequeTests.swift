//
//  DequeTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class DequeTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var deque: Deque<Int> = {
        return Deque<Int>(array: DequeTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Deque<Int>().isEmpty)
        XCTAssertTrue(Deque<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(deque.front, 5)
    }

    func testBack() {
        XCTAssertEqual(deque.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(deque.count, DequeTests.integers.count)
        XCTAssertEqual(deque.array, DequeTests.integers)
    }

    func testCount() {
        XCTAssertEqual(deque.count, DequeTests.integers.count)
        XCTAssertEqual(Deque<Int>().count, 0)
        XCTAssertEqual(Deque(arrayLiteral: 1, 2, 3).count, 3)
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
        _ = (0..<deque.count).map { XCTAssertEqual(deque.pop(), SimpleQueueTests.integers[$0]) }
        XCTAssertNil(deque.pop())
    }

    func testPopBack() {
        let maxIndex = StackTests.integers.count - 1
        _ = (0..<deque.count).map { XCTAssertEqual(deque.popBack(), SimpleQueueTests.integers[maxIndex - $0]) }
        XCTAssertNil(deque.popBack())
    }

    func testClear() {
        deque.clear()
        XCTAssertEqual(deque.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(deque.description, String(describing: DequeTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in deque {
            XCTAssertEqual(item, DequeTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let deque = Deque(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(deque.count, 4)
        XCTAssertEqual(deque.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(deque.array, DequeTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let deque = Deque<Int>(maxSize: maxSize)
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
        let deque = Deque<Int>(maxSize: maxSize)
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
