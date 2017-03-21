//
//  SimpleQueue.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import Foundation

// MARK: - SimpleQueue
/*
 `SimpleQueue` is using an `Array` as the underlying mechanism for storing data.
 Because of this, the `pop` operation is not optimized:
 - The `push` operation requires constant time O(1), as we are just appending to the array.
 - The `pop` operation, instead, requires linear time O(n) because `Array` needs to rearrange
   the entire array after removing the first item.
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

    public convenience init(array: Array<T>) {
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

// MARK: - SimpleQueue to Array<T>
extension SimpleQueue {
    var array: [T] {
        return items
    }
}
