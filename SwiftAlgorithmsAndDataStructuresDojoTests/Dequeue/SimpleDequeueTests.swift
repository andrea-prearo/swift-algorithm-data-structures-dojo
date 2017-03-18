//
//  SimpleDequeueTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class SimpleDequeueTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var dequeue: SimpleDequeue<Int> = {
        return SimpleDequeue<Int>(array: SimpleDequeueTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(SimpleDequeue<Int>().isEmpty)
        XCTAssertTrue(SimpleDequeue<String>().isEmpty)
    }

    func testFront() {
        XCTAssertEqual(dequeue.front, 5)
    }
    
    func testBack() {
        XCTAssertEqual(dequeue.back, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(dequeue.count, SimpleDequeueTests.integers.count)
        XCTAssertEqual(dequeue.array, SimpleDequeueTests.integers)
    }

    func testCount() {
        XCTAssertEqual(dequeue.count, SimpleDequeueTests.integers.count)
        XCTAssertEqual(SimpleDequeue<Int>().count, 0)
        XCTAssertEqual(SimpleDequeue(arrayLiteral: 1, 2, 3).count, 3)
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
        _ = (0..<dequeue.count).map { XCTAssertEqual(dequeue.pop(), SimpleDequeueTests.integers[$0]) }
        XCTAssertNil(dequeue.pop())
    }
    
    func testPopBack() {
        let maxIndex = StackTests.integers.count - 1
        _ = (0..<dequeue.count).map { XCTAssertEqual(dequeue.popBack(), SimpleDequeueTests.integers[maxIndex - $0]) }
        XCTAssertNil(dequeue.popBack())
    }

    func testClear() {
        dequeue.clear()
        XCTAssertEqual(dequeue.count, 0)
    }

    func testDescription() {
        XCTAssertEqual(dequeue.description, String(describing: SimpleDequeueTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in dequeue {
            XCTAssertEqual(item, SimpleDequeueTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let dequeue = SimpleDequeue(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(dequeue.count, 4)
        XCTAssertEqual(dequeue.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(dequeue.array, SimpleDequeueTests.integers)
    }

    func testPushOutOfSpaceError() {
        let maxSize = 10
        let dequeue = SimpleDequeue<Int>(maxSize: maxSize)
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
        let dequeue = SimpleDequeue<Int>(maxSize: maxSize)
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
