//
//  BinaryHeap.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 5/18/17.
//
//

import Foundation

// MARK: - BinaryHeapOrder
public enum BinaryHeapOrder {
    case min
    case max
}

// MARK: - BinaryHeapResize
public enum BinaryHeapResize {
    case grow
    case shrink
}

/*
 The `key` property of `BinaryHeapElement` will be used for ordering the nodes.
 This requires `key` to be of `Comparable` type so we can define an ordering for the nodes.
 */
public class BinaryHeapElement<K: Comparable, T: Comparable> {
    var key: K
    var value: T

    public init(key: K, value: T) {
        self.key = key
        self.value = value
    }
}

// MARK: - BinaryHeapElement + CustomStringConvertible
extension BinaryHeapElement: CustomStringConvertible {
    public var description: String {
        return "[\(key), \(value)]"
    }
}

// MARK: - BinaryHeapElement + Equatable
extension BinaryHeapElement: Equatable {}

public func ==<K: Comparable, T: Comparable>(lhs: BinaryHeapElement<K, T>, rhs: BinaryHeapElement<K, T>) -> Bool {
    guard lhs.key == rhs.key, lhs.value == lhs.value else {
        return false
    }
    return true
}

// MARK: - BinaryHeap: Lifecycle
/*
 `BinaryHeap` requires the concept of order. This is the reason why the generic
 type `K` has to be `Comparable`. We need to be able to compare the data of each element to
 implement operations such as `insert`, `remove` and `search`.
 */
public class BinaryHeap<K: Comparable, T: Comparable> {
    fileprivate let chunkSize: Int = 64
    fileprivate var availableSize: Int = 0
    fileprivate var heap: [BinaryHeapElement<K, T>]

    fileprivate(set) var type: BinaryHeapOrder

    public var count: Int {
        return heap.count
    }

    public var isEmpty: Bool {
        return heap.count == 0
    }

    public var peek: BinaryHeapElement<K, T>? {
        return heap.first
    }

    public init(type: BinaryHeapOrder = .min) {
        self.type = type
        heap = []
        resize(.grow)
    }

    public convenience init(type: BinaryHeapOrder = .min, array: [BinaryHeapElement<K, T>]) {
        self.init(type: type)

        for item in array {
            insert(newElement: item)
        }
    }

    public convenience init(type: BinaryHeapOrder = .min, arrayLiteral elements: BinaryHeapElement<K, T>...) {
        self.init(type: type)

        for element in elements {
            insert(newElement: element)
        }
    }
}

// MARK: - BinaryHeap: Order-based operations
public extension BinaryHeap {
    func search(key: K) -> BinaryHeapElement<K, T>? {
        for item in heap where item.key == key {
            return item
        }
        return nil
    }

    func insert(newElement: BinaryHeapElement<K, T>) {
        insert(key: newElement.key, value: newElement.value)
    }

    func insert(key: K, value: T) {
        let newIndex = count
        if newIndex > availableSize {
            resize(.grow)
        }
        heap.append(BinaryHeapElement(key: key, value: value))
        bubbleUp()
    }

    func remove() -> BinaryHeapElement<K, T>? {
        let root = peek
        let newCount = count - 1
        heap[0] = heap[newCount]
        heap.remove(at: newCount)
        bubbleDown()
        if availableSize - newCount == chunkSize {
            resize(.shrink)
        }
        return root
    }

    subscript(key: K) -> BinaryHeapElement<K, T>? {
        return search(key: key)
    }
}

// MARK: - Private Methods
fileprivate extension BinaryHeap {
    func parent(_ index: Int) -> Int {
        return (index - 1) / 2
    }

    func left(_ index: Int) -> Int {
        return 2 * index + 1
    }

    func right(_ index: Int) -> Int {
        return 2 * index + 2
    }

    func hasParent(_ index: Int) -> Bool {
        return index > 0
    }

    func hasLeft(_ index: Int) -> Bool {
        return left(index) < count
    }

    func hasRight(_ index: Int) -> Bool {
        return right(index) < count
    }

    func resize(_ method: BinaryHeapResize) {
        switch method {
        case .shrink:
            availableSize -= chunkSize
            if availableSize < 0 {
                availableSize = 0
            }
        default: // .grow
            availableSize += chunkSize
        }
        heap.reserveCapacity(availableSize)
    }

    /// Returns wheter the heap elements, specified by their indexes, are ordered.
    /// The order depends on the chosen heap type (min or max).
    ///
    /// - Parameters:
    ///   - indexA: index of the element that should be closer to the root (heap[0])
    ///   - indexB: index of the element compare to heap[indexA] to verify the order
    /// - Returns: wheter the heap elements, specified by indexA and indexB, are ordered.
    func isOrdered(indexA: Int, indexB: Int) -> Bool {
        switch type {
        case .max:
            return heap[indexB].key < heap[indexA].key
        default: // .min
            return heap[indexA].key < heap[indexB].key
        }
    }

    func bubbleUp() {
        var index = count - 1
        var indexParent = parent(index)
        while hasParent(index) && !isOrdered(indexA: indexParent, indexB: index) {
            (heap[index], heap[indexParent]) = (heap[indexParent], heap[index])
            index = indexParent
            indexParent = parent(index)
        }
    }

    func bubbleDown() {
        var index = 0
        while hasLeft(index) {
            var smallerChild = left(index)
            if hasRight(index) && !isOrdered(indexA: left(index), indexB: right(index)) {
                smallerChild = right(index)
            }
            if !isOrdered(indexA: index, indexB: smallerChild) {
                (heap[index], heap[smallerChild]) = (heap[smallerChild], heap[index])
            } else {
                break
            }
            index = smallerChild
        }
    }

    func dump() -> String {
        return heap.map { $0.description }.joined(separator: ", ")
    }
}

// MARK: - BinaryHeap + CustomStringConvertible
extension BinaryHeap: CustomStringConvertible {
    public var description: String {
        return dump()
    }
}

// MARK: - BinaryHeap to Array
extension BinaryHeap {
    var array: [BinaryHeapElement<K, T>] {
        return heap
    }
}

// MARK: - BinaryHeap + Equatable
extension BinaryHeap: Equatable {}

public func ==<K: Comparable, T: Comparable>(lhs: BinaryHeap<K, T>, rhs: BinaryHeap<K, T>) -> Bool {
    return lhs.array == rhs.array
}
