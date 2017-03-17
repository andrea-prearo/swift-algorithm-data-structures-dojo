//
//  Stack.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import Foundation

public enum StackError: Error {
    case outOfSpace
}

// MARK: - Stack
public final class Stack<T> {
    fileprivate var items: [T] = []
    fileprivate var maxSize: Int = Int.max

    public var count: Int {
        return items.count
    }

    public var top: T? {
        return items.last
    }
    
    public var isEmpty: Bool {
        return top == nil
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
            throw StackError.outOfSpace
        }
        items.append(item)
    }

    public func pop() -> T? {
        if items.count == 0 {
            return nil
        }
        return items.popLast()
    }

    public func clear() {
        items = []
    }
}

// MARK: - Stack + CustomStringConvertible
extension Stack: CustomStringConvertible {
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

// MARK: - Stack + Sequence
extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator {
            return self.pop()
        }
    }
}

// MARK: - Stack + ExpressibleByArrayLiteral
extension Stack: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            try? self.push(element)
        }
    }
}

// MARK: - Stack to Array<T>
extension Stack {
    var array: [T] {
        return items
    }
}
