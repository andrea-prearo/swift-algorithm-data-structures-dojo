//
//  LinkedListTests.swift
//  SwiftAlgorithmsAndDataStructuresDojoTests
//
//  Created by Prearo, Andrea on 3/12/17.
//
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

    func testRemoveHead() {
        list.removeHead()
        var integers = LinkedListTests.integers
        XCTAssertEqual(list.count, integers.count - 1)
        integers.removeFirst()
        XCTAssertEqual(list.array, integers)
    }

    func testRemoveTail() {
        list.removeTail()
        var integers = LinkedListTests.integers
        XCTAssertEqual(list.count, integers.count - 1)
        integers.removeLast()
        XCTAssertEqual(list.array, integers)
    }

    func testRemoveAll() {
        list.removeAll()
        XCTAssertEqual(list.count, 0)
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
    }

    func testSubscript() {
        _ = (0..<list.count).map {
            XCTAssertEqual(list[$0], LinkedListTests.integers[$0])
        }
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

    func testExpressibleByArrayLiteral() {
        let list = LinkedList(arrayLiteral: 0, 1, 2, 3)
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list.array, [0, 1, 2, 3])
    }

    func testAsArray() {
        XCTAssertEqual(list.array, LinkedListTests.integers)
    }
}
