//
//  deque.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

public enum DequeueError: Error {
    case outOfSpace
}

// MARK: - Deque
/*
 `Queue` is an optimized implementation which uses a (doubly) linked list as the underlying 
 storage mechanism to allow all operations to be executed in constant time **O(1)**.
 */
public final class Deque<T> {
    fileprivate let list = LinkedList<T>()
    fileprivate var maxSize: Int = Int.max

    public var count: Int {
        return list.count
    }

    public var front: T? {
        return list.head?.value
    }

    public var back: T? {
        return list.tail?.value
    }

    public var isEmpty: Bool {
        return list.count == 0
    }

    public convenience init(maxSize: Int) {
        self.init()
        self.maxSize = maxSize
    }

    public convenience init(array: [T]) {
        self.init()

        for element in array {
            try? self.push(element)
        }
    }

    public func push(_ item: T) throws {
        if list.count == maxSize {
            throw DequeueError.outOfSpace
        }
        list.append(item)
    }

    public func pushFront(_ item: T) throws {
        if list.count == maxSize {
            throw DequeueError.outOfSpace
        }
        list.insert(item, at: 0)
    }

    public func pop() -> T? {
        if isEmpty {
            return nil
        }
        return list.removeHead()
    }

    public func popBack() -> T? {
        if isEmpty {
            return nil
        }
        return list.removeTail()
    }

    public func clear() {
        list.removeAll()
    }
}

// MARK: - Deque + CustomStringConvertible
extension Deque: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}

// MARK: - Deque + Sequence
extension Deque: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator {
            return self.pop()
        }
    }
}

// MARK: - Deque + ExpressibleByArrayLiteral
extension Deque: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            try? self.push(element)
        }
    }
}

// MARK: - Deque to [T]
extension Deque {
    var array: [T] {
        return list.array
    }
}
