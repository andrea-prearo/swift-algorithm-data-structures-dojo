//
//  QueueTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class QueueTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var queue: Queue<Int> = {
        return Queue<Int>(array: QueueTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Queue<Int>().isEmpty)
        XCTAssertTrue(Queue<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(queue.front, 5)
    }
    
    func testBack() {
        XCTAssertEqual(queue.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(queue.count, QueueTests.integers.count)
        XCTAssertEqual(queue.array, QueueTests.integers)
    }

    func testCount() {
        XCTAssertEqual(queue.count, QueueTests.integers.count)
        XCTAssertEqual(Queue<Int>().count, 0)
        XCTAssertEqual(Queue(arrayLiteral: 1, 2, 3).count, 3)
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
        XCTAssertEqual(queue.pop(), 5)
    }

    func testClear() {
        queue.clear()
        XCTAssertEqual(queue.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(queue.description, String(describing: QueueTests.integers))
    }

    func testExpressibleByArrayLiteral() {
        let queue = Queue(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(queue.count, 4)
        XCTAssertEqual(queue.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(queue.array, QueueTests.integers)
    }
}
