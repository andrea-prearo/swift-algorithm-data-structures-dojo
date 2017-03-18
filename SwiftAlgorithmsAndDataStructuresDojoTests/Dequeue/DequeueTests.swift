//
//  DequeueTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class DequeueTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var queue: Dequeue<Int> = {
        return Dequeue<Int>(array: DequeueTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Dequeue<Int>().isEmpty)
        XCTAssertTrue(Dequeue<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(queue.front, 5)
    }
    
    func testBack() {
        XCTAssertEqual(queue.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(queue.count, DequeueTests.integers.count)
        XCTAssertEqual(queue.array, DequeueTests.integers)
    }

    func testCount() {
        XCTAssertEqual(queue.count, DequeueTests.integers.count)
        XCTAssertEqual(Dequeue<Int>().count, 0)
        XCTAssertEqual(Dequeue(arrayLiteral: 1, 2, 3).count, 3)
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

    func testPushFront() {
        let newValue = 1000
        do {
            try queue.pushFront(newValue)
            XCTAssertEqual(queue.front, newValue)
            XCTAssertEqual(queue.back, 8)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPop() {
        XCTAssertEqual(queue.pop(), 5)
    }

    func testPopBack() {
        XCTAssertEqual(queue.popBack(), 8)
    }

    func testClear() {
        queue.clear()
        XCTAssertEqual(queue.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(queue.description, String(describing: DequeueTests.integers))
    }

    func testExpressibleByArrayLiteral() {
        let queue = Dequeue(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(queue.count, 4)
        XCTAssertEqual(queue.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(queue.array, DequeueTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let queue = Dequeue<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? queue.push($0) }
        do {
            try queue.push(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }

    func testPushFrontOutOfSpaceError() {
        let maxSize = 10
        let queue = Dequeue<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? queue.pushFront($0) }
        do {
            try queue.pushFront(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }
}
