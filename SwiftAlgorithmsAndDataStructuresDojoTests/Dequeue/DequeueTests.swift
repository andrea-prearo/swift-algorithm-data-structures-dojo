//
//  DequeueTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class DequeueTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var dequeue: Dequeue<Int> = {
        return Dequeue<Int>(array: DequeueTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(Dequeue<Int>().isEmpty)
        XCTAssertTrue(Dequeue<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(dequeue.front, 5)
    }
    
    func testBack() {
        XCTAssertEqual(dequeue.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(dequeue.count, DequeueTests.integers.count)
        XCTAssertEqual(dequeue.array, DequeueTests.integers)
    }

    func testCount() {
        XCTAssertEqual(dequeue.count, DequeueTests.integers.count)
        XCTAssertEqual(Dequeue<Int>().count, 0)
        XCTAssertEqual(Dequeue(arrayLiteral: 1, 2, 3).count, 3)
    }

    func testPush() {
        let newValue = 1000
        do {
            try dequeue.push(newValue)
            XCTAssertEqual(dequeue.front, 5)
            XCTAssertEqual(dequeue.back, newValue)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPushFront() {
        let newValue = 1000
        do {
            try dequeue.pushFront(newValue)
            XCTAssertEqual(dequeue.front, newValue)
            XCTAssertEqual(dequeue.back, 8)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testPop() {
        _ = (0..<dequeue.count).map { XCTAssertEqual(dequeue.pop(), SimpleQueueTests.integers[$0]) }
        XCTAssertNil(dequeue.pop())
    }

    func testPopBack() {
        let maxIndex = StackTests.integers.count - 1
        _ = (0..<dequeue.count).map { XCTAssertEqual(dequeue.popBack(), SimpleQueueTests.integers[maxIndex - $0]) }
        XCTAssertNil(dequeue.popBack())
    }

    func testClear() {
        dequeue.clear()
        XCTAssertEqual(dequeue.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(dequeue.description, String(describing: DequeueTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in dequeue {
            XCTAssertEqual(item, DequeueTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let dequeue = Dequeue(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(dequeue.count, 4)
        XCTAssertEqual(dequeue.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(dequeue.array, DequeueTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let dequeue = Dequeue<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? dequeue.push($0) }
        do {
            try dequeue.push(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }

    func testPushFrontOutOfSpaceError() {
        let maxSize = 10
        let dequeue = Dequeue<Int>(maxSize: maxSize)
        _ = (0..<maxSize).map { try? dequeue.pushFront($0) }
        do {
            try dequeue.pushFront(maxSize)
        } catch let error {
            XCTAssertEqual(error.localizedDescription, DequeueError.outOfSpace.localizedDescription)
            return
        }
        XCTFail("push didn't throw a StackError.outOfSpace exception")
    }
}
