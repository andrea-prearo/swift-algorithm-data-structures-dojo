//
//  Queue.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

public enum QueueError: Error {
    case outOfSpace
}

// MARK: - Queue
/*
 `Queue` is using a `LinkedList` as the underlying mechanism for storing data.
 This allows all operations to be executed in constant time O(1).
 */
public final class Queue<T> {
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
            throw QueueError.outOfSpace
        }
        list.append(item)
    }

    public func pop() -> T? {
        if isEmpty {
            return nil
        }
        return list.removeHead()
    }

    public func clear() {
        list.removeAll()
    }
}

// MARK: - Queue + CustomStringConvertible
extension Queue: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}

// MARK: - Queue + Sequence
extension Queue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator {
            return self.pop()
        }
    }
}

// MARK: - Queue + ExpressibleByArrayLiteral
extension Queue: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            try? self.push(element)
        }
    }
}

// MARK: - Queue to [T]
extension Queue {
    var array: [T] {
        return list.array
    }
}
