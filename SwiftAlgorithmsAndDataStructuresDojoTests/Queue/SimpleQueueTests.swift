//
//  SimpleQueueTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Andrea Prearo on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class SimpleQueueTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var queue: SimpleQueue<Int> = {
        return SimpleQueue<Int>(array: SimpleQueueTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(SimpleQueue<Int>().isEmpty)
        XCTAssertTrue(SimpleQueue<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(queue.front, 5)
    }

    func testBack() {
        XCTAssertEqual(queue.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(queue.count, SimpleQueueTests.integers.count)
        XCTAssertEqual(queue.array, SimpleQueueTests.integers)
    }

    func testCount() {
        XCTAssertEqual(queue.count, SimpleQueueTests.integers.count)
        XCTAssertEqual(SimpleQueue<Int>().count, 0)
        XCTAssertEqual(SimpleQueue(arrayLiteral: 1, 2, 3).count, 3)
    }

    func testPush() {
        let newValue = 1000
        do {
            try queue.push(newValue)
            XCTAssertEqual(queue.front, 5)
            XCTAssertEqual(queue.back, newValue)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPop() {
        _ = (0..<queue.count).map { XCTAssertEqual(queue.pop(), SimpleQueueTests.integers[$0]) }
        XCTAssertNil(queue.pop())
    }

    func testClear() {
        queue.clear()
        XCTAssertEqual(queue.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(queue.description, String(describing: SimpleQueueTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in queue {
            XCTAssertEqual(item, SimpleQueueTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let queue = SimpleQueue(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(queue.count, 4)
        XCTAssertEqual(queue.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(queue.array, SimpleQueueTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let queue = SimpleQueue<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? queue.push($0) }
        do {
            try queue.push(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, QueueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }
}
