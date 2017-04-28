//
//  SimpleQueue.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 3/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

// MARK: - SimpleQueue
/*
 `SimpleQueue` uses an array as the underlying storage mechanism.
 Because of this, the `pop` operation is not optimized:
 - The `push` operation requires constant time **O(1)** as we are just appending to the array.
 - The `pop` operation, instead, requires linear time **O(n)** because the array needs to be 
   rearranged after removing the first item.
 */
public final class SimpleQueue<T> {
    fileprivate var items: [T] = []
    fileprivate var maxSize: Int = Int.max

    public var count: Int {
        return items.count
    }

    public var front: T? {
        return items.first
    }

    public var back: T? {
        return items.last
    }

    public var isEmpty: Bool {
        return items.count == 0
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
        if items.count == maxSize {
            throw QueueError.outOfSpace
        }
        items.append(item)
    }

    public func pop() -> T? {
        if isEmpty {
            return nil
        }
        return items.removeFirst()
    }

    public func clear() {
        items = []
    }
}

// MARK: - SimpleQueue + CustomStringConvertible
extension SimpleQueue: CustomStringConvertible {
    public var description: String {
        var string = "["
        _ = (0..<items.count).map {
            string += "\(items[$0])"
            if $0 < items.count - 1 {
                string += ", "
            }
        }
        return string + "]"
    }
}

// MARK: - SimpleQueue + Sequence
extension SimpleQueue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator {
            return self.pop()
        }
    }
}

// MARK: - SimpleQueue + ExpressibleByArrayLiteral
extension SimpleQueue: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            try? self.push(element)
        }
    }
}

// MARK: - SimpleQueue to [T]
extension SimpleQueue {
    var array: [T] {
        return items
    }
}
