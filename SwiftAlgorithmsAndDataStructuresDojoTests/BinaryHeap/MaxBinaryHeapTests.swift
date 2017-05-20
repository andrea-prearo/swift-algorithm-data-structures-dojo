//
//  MaxBinaryHeapTests.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 5/19/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class MaxBinaryHeapTests: XCTestCase {
    static let heapDescription: [String] = [
        "[90, F]", "[72, J]", "[79, E]", "[58, I]", "[59, A]", "[23, C]", "[69, G]", "[42, B]", "[50, H]", "[56, D]"]
    static let elements = [
        BinaryHeapElement(key: 59, value: "A"),
        BinaryHeapElement(key: 42, value: "B"),
        BinaryHeapElement(key: 23, value: "C"),
        BinaryHeapElement(key: 56, value: "D"),
        BinaryHeapElement(key: 79, value: "E"),
        BinaryHeapElement(key: 90, value: "F"),
        BinaryHeapElement(key: 69, value: "G"),
        BinaryHeapElement(key: 50, value: "H"),
        BinaryHeapElement(key: 58, value: "I"),
        BinaryHeapElement(key: 72, value: "J")
    ]
    static let orderedElements = MaxBinaryHeapTests.elements.sorted { (element1, element2) -> Bool in
        element1.key > element2.key
    }

    lazy var heap: BinaryHeap<Int, String> = {
        let h = BinaryHeap<Int, String>(type: .max)
        for element in MaxBinaryHeapTests.elements {
            h.insert(newElement: element)
        }
        return h
    }()

    func testElementEquality() {
        XCTAssertEqual(heap.peek, MaxBinaryHeapTests.orderedElements.first)
        XCTAssertNotEqual(heap.peek, MaxBinaryHeapTests.orderedElements.last)
        XCTAssertNotEqual(heap.peek, nil)
        XCTAssertEqual(BinaryHeap<Int, Int>().peek, nil)
        XCTAssertNotEqual(BinaryHeap<Int, String>().peek, MaxBinaryHeapTests.orderedElements.first)
    }

    func testIsEmpty() {
        XCTAssertTrue(BinaryHeap<Int, Int>().isEmpty)
        XCTAssertTrue(BinaryHeap<Int, String>().isEmpty)
    }

    func testInitFromArray() {
        let newHeap = BinaryHeap(type: .max, array: MaxBinaryHeapTests.elements)
        XCTAssertEqual(newHeap, heap)
    }

    func testExpressibleByArrayLiteral() {
        let heap = BinaryHeap<Int, String>(type: .max)
        let elements = [
            BinaryHeapElement(key: 32, value: "ATP"),
            BinaryHeapElement(key: 4, value: "FTJ"),
            BinaryHeapElement(key: 75, value: "ORN"),
            BinaryHeapElement(key: 42, value: "THA")
        ]
        for element in elements {
            heap.insert(newElement: element)
        }
        let newTree = BinaryHeap(type: .max, arrayLiteral: BinaryHeapElement(key: 32, value: "ATP"),
                                 BinaryHeapElement(key: 4, value: "FTJ"),
                                 BinaryHeapElement(key: 75, value: "ORN"),
                                 BinaryHeapElement(key: 42, value: "THA"))
        XCTAssertEqual(newTree, heap)
    }

    func testDescription() {
        XCTAssertEqual(heap.description, MaxBinaryHeapTests.heapDescription.joined(separator: ", "))
        XCTAssertEqual(BinaryHeap<Int, String>().description, "")
    }

    func testSearchFailure() {
        XCTAssertEqual(heap.search(key: 1), nil)
    }

    func testSearchSuccess() {
        for element in MaxBinaryHeapTests.elements {
            XCTAssertEqual(heap.search(key: element.key), element)
        }
    }

    func testPeek() {
        XCTAssertEqual(heap.peek, BinaryHeapElement(key: 90, value: "F"))
    }

    func testInsert() {
        let heap = BinaryHeap<Int, String>()
        let elements = [
            BinaryHeapElement(key: 1, value: "A"),
            BinaryHeapElement(key: 2, value: "B"),
            BinaryHeapElement(key: 3, value: "C"),
            BinaryHeapElement(key: 4, value: "D"),
            BinaryHeapElement(key: 5, value: "E"),
            BinaryHeapElement(key: 6, value: "F"),
            BinaryHeapElement(key: 7, value: "G"),
            BinaryHeapElement(key: 8, value: "H"),
            BinaryHeapElement(key: 9, value: "I")
        ]
        var insertOrder = (0..<elements.count).map { $0 }
        insertOrder.shuffle()
        _ = (0..<insertOrder.count).map { heap.insert(newElement: elements[$0]) }
        testSearchSuccess()
    }

    func testRemove() {
        for element in MaxBinaryHeapTests.orderedElements {
            XCTAssertEqual(heap.remove(), element)
        }
    }

    func testSubscript() {
        for element in MaxBinaryHeapTests.elements {
            XCTAssertEqual(heap[element.key], element)
        }
    }

    func testSizeGrowAndShrink() {
        let heap = BinaryHeap<Int, String>()
        _ = (0..<130).map { heap.insert(key: $0, value: "dummy") }
        XCTAssertEqual(heap.count, 130)
        _ = (0..<130).map { _ in heap.remove() }
        XCTAssertEqual(heap.count, 0)
    }
}

fileprivate extension MaxBinaryHeapTests {
    func heapDescription(_ element: BinaryHeapElement<Int, String>?) -> String {
        let nodeDump: String = {
            guard let element = element else {
                return "-"
            }
            return element.description
        }()
        return nodeDump
    }
}
