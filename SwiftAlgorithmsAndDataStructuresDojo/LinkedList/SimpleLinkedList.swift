//
//  SimpleSimpleLinkedList.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 5/16/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

// MARK: - SimpleListNode
public class SimpleListNode<T> {
    var value: T
    var next: SimpleListNode?

    init(value: T) {
        self.value = value
        self.next = nil
    }

    init(value: T, next: SimpleListNode<T>?) {
        self.value = value
        self.next = next
    }
}

// MARK: - SimpleListNode + CustomStringConvertible
extension SimpleListNode: CustomStringConvertible {
    public var description: String {
        return String(describing: value)
    }
}

// MARK: - SimpleLinkedList
public final class SimpleLinkedList<T> {
    fileprivate(set) public var head: SimpleListNode<T>?
    fileprivate(set) public var tail: SimpleListNode<T>?
    fileprivate(set) public var count: Int = 0

    public var isEmpty: Bool {
        return head == nil
    }

    public convenience init(array: [T]) {
        self.init()

        for element in array {
            self.append(element)
        }
    }

    public func append(_ value: T) {
        let node = SimpleListNode(value: value)
        if head == nil {
            head = node
        }
        tail?.next = node
        tail = node
        count += 1
    }

    public func node(at index: Int) -> SimpleListNode<T>? {
        guard 0..<self.count ~= index else {
            return nil
        }

        var count: Int = 0
        var node = head
        while node != nil {
            if count == index {
                return node
            }
            node = node!.next
            count += 1
        }
        return nil
    }

    public func insert(_ value: T, at index: Int) {
        guard let nodeAtIndex = node(at: index) else {
            if index == count {
                append(value)
            }
            return
        }
        let newNode = SimpleListNode(value: value, next: nodeAtIndex)
        if index == 0 {
            head = newNode
        } else if index == count - 1 {
            tail = newNode
        }
        count += 1
    }

    public func removeHead() -> T? {
        let value = head?.value
        head = head?.next
        count -= 1
        return value
    }

    public func removeTail() -> T? {
        let value = tail?.value
        var currentNode = head
        var currentTail: SimpleListNode<T>?
        while currentNode != nil {
            currentTail = currentNode
            if currentNode?.next?.next == nil {
                // currentNode?.next is the current tail
                currentNode?.next = nil
            }
            currentNode = currentNode?.next
        }
        tail = currentTail
        count -= 1
        return value
    }

    public func removeAll() {
        head = nil
        tail = nil
        count = 0
    }

    public subscript(index: Int) -> T? {
        guard let node = node(at: index) else {
            return nil
        }
        return node.value
    }

    public func reverse() {
        tail = head
        var currentNode = head
        var previousNode: SimpleListNode<T>?
        while currentNode != nil {
            let next = currentNode!.next
            currentNode!.next = previousNode
            previousNode = currentNode
            currentNode = next
        }
        head = previousNode
    }

    public func reversed() -> SimpleLinkedList<T> {
        let reverserdList = SimpleLinkedList<T>()
        var currentNode = head
        while currentNode != nil {
            reverserdList.append(currentNode!.value)
            currentNode = currentNode?.next
        }
        reverserdList.reverse()
        return reverserdList
    }
}

// MARK: - SimpleLinkedList + CustomStringConvertible
extension SimpleLinkedList: CustomStringConvertible {
    public var description: String {
        var string = "["
        var node = head
        while node != nil {
            string += "\(node!.value)"
            node = node!.next
            if node != nil {
                string += ", "
            }
        }
        return string + "]"
    }
}

// MARK: - SimpleListNodeIterator
public struct SimpleListNodeIterator<T>: IteratorProtocol {
    public typealias Element = T

    private var head: SimpleListNode<Element>?

    fileprivate init(head: SimpleListNode<T>?) {
        self.head = head
    }

    mutating public func next() -> T? {
        if head != nil {
            let item = head!.value
            head = head!.next
            return item
        }
        return nil
    }
}

// MARK: - SimpleLinkedList + Sequence
extension SimpleLinkedList: Sequence {
    public typealias Iterator = SimpleListNodeIterator<T>

    public func makeIterator() -> Iterator {
        return Iterator(head: head)
    }
}

// MARK: - SimpleLinkedList + ExpressibleByArrayLiteral
extension SimpleLinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            self.append(element)
        }
    }
}

// MARK: - SimpleLinkedList to [T]
extension SimpleLinkedList {
    var array: [T] {
        var items: [T] = []
        var node = head
        while node != nil {
            items.append(node!.value)
            node = node!.next
        }
        return items
    }
}
