//
//  LinkedListTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Andrea Prearo on 3/12/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class LinkedListTests: XCTestCase {
    static let integers = [5, -1, 8, 3, -24, 32, 0, 8]
    lazy var list: LinkedList<Int> = {
        return LinkedList<Int>(array: LinkedListTests.integers)
    }()

    func testIsEmpty() {
        XCTAssertTrue(LinkedList<Int>().isEmpty)
        XCTAssertTrue(LinkedList<String>().isEmpty)
    }

    func testHead() {
        XCTAssertEqual(list.head?.value, 5)
    }

    func testTail() {
        XCTAssertEqual(list.tail?.value, 8)
    }

    func testInitFromArray() {
        XCTAssertEqual(list.count, LinkedListTests.integers.count)
        XCTAssertEqual(list.array, LinkedListTests.integers)
    }

    func testCount() {
        XCTAssertEqual(list.count, LinkedListTests.integers.count)
        XCTAssertEqual(LinkedList<Int>().count, 0)
        XCTAssertEqual(LinkedList(arrayLiteral: 1, 2, 3).count, 3)
    }

    func testAppend() {
        let newValue = 1000
        list.append(newValue)
        XCTAssertEqual(list.tail?.value, newValue)
        XCTAssertEqual(list[list.count - 1], newValue)
    }

    func testNodeAtIndex() {
        _ = (0..<list.count).map {
            let node = list.node(at: $0)
            XCTAssertEqual(node?.value, LinkedListTests.integers[$0])
            if $0 == 0 {
                XCTAssertNotNil(node?.next)
                XCTAssertNil(node?.previous)
            } else if $0 == list.count - 1 {
                XCTAssertNil(node?.next)
                XCTAssertNotNil(node?.previous)
            } else {
                XCTAssertNotNil(node?.next)
                XCTAssertNotNil(node?.previous)
            }
        }
        XCTAssertNil(list.node(at: -1))
        XCTAssertNil(list.node(at: list.count))
        XCTAssertNil(list.node(at: list.count + 1))
    }

    func testInsertNodeAtIndex() {
        let headValue = 1000
        let tailValue = headValue
        let integers = [0, 1, 2, 3]
        let list = LinkedList<Int>(array: integers)
        XCTAssertTrue(list.insert(headValue, at: 0))
        XCTAssertEqual(list.count, integers.count + 1)
        XCTAssertEqual(list.head?.value, headValue)
        XCTAssertTrue(list.insert(tailValue, at: list.count - 1))
        XCTAssertEqual(list.count, integers.count + 2)
        XCTAssertEqual(list.tail?.value, tailValue)
        XCTAssertTrue(list.insert(2001, at: list.count))
        let value = 1001
        XCTAssertFalse(list.insert(value, at: -1))
        XCTAssertFalse(list.insert(value, at: list.count + 1))
    }

    func testRemoveHead() {
        XCTAssertEqual(list.removeHead(), 5)
        var integers = LinkedListTests.integers
        XCTAssertEqual(list.count, integers.count - 1)
        integers.removeFirst()
        XCTAssertEqual(list.array, integers)
    }

    func testRemoveTail() {
        XCTAssertEqual(list.removeTail(), 8)
        var integers = LinkedListTests.integers
        XCTAssertEqual(list.count, integers.count - 1)
        integers.removeLast()
        XCTAssertEqual(list.array, integers)
    }

    func testRemoveAll() {
        list.removeAll()
        XCTAssertEqual(list.count, 0)
    }

    func testSubscript() {
        _ = (0..<list.count).map {
            XCTAssertEqual(list[$0], LinkedListTests.integers[$0])
        }
        XCTAssertNil(list[-1])
        XCTAssertNil(list[list.count])
    }

    func testReverse() {
        list.reverse()
        let integers = LinkedListTests.integers.reversed().map { $0 }
        _ = (0..<list.count).map {
            XCTAssertEqual(list[$0], integers[$0])
        }
    }

    func testReversed() {
        let reversedList = list.reversed()
        let integers = LinkedListTests.integers.reversed().map { $0 }
        _ = (0..<list.count).map {
            XCTAssertEqual(reversedList[$0], integers[$0])
        }
    }

    func testDescription() {
        XCTAssertEqual(list.description, String(describing: LinkedListTests.integers))
    }

    func testSequence() {
        var index = 0
        for item in list {
            XCTAssertEqual(item, LinkedListTests.integers[index])
            index += 1
        }
    }

    func testExpressibleByArrayLiteral() {
        let list = LinkedList(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(list.array, LinkedListTests.integers)
    }
}
