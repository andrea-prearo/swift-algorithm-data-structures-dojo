//
//  LinkedList.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/12/17.
//
//

import Foundation

// MARK: - ListNode
public class ListNode<T> {
    var value: T
    var next: ListNode?
    weak var previous: ListNode?

    init(value: T) {
        self.value = value
        self.next = nil
    }

    init(value: T, next: ListNode<T>?) {
        self.value = value
        self.next = next
    }
}

// MARK: - ListNode + CustomStringConvertible
extension ListNode: CustomStringConvertible {
    public var description: String {
        return String(describing: value)
    }
}

// MARK: - LinkedList
public final class LinkedList<T> {
    fileprivate(set) public var head: ListNode<T>?
    fileprivate(set) public var tail: ListNode<T>?
    fileprivate(set) public var count: Int = 0

    public var isEmpty: Bool {
        return head == nil
    }

    public convenience init(array: Array<T>) {
        self.init()
        
        for element in array {
            self.append(element)
        }
    }

    public func append(_ value: T) {
        let node = ListNode(value: value)
        if head == nil {
            head = node
        }
        node.previous = tail
        tail?.next = node
        tail = node
        count += 1
    }

    public func node(at index: Int) -> ListNode<T>? {
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
        let nodeAtIndex = node(at: index)
        let newNode = ListNode(value: value, next: nodeAtIndex)
        newNode.previous = nodeAtIndex?.previous
        nodeAtIndex?.previous = newNode
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
        tail?.previous?.next = nil
        tail = tail?.previous
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
        var previousNode: ListNode<T>?
        while currentNode != nil {
            let next = currentNode!.next
            currentNode!.next = previousNode
            previousNode = currentNode
            currentNode = next
        }
        head = previousNode
    }

    public func reversed() -> LinkedList<T> {
        let reverserdList = LinkedList<T>()
        var currentNode = tail
        while currentNode != nil {
            reverserdList.append(currentNode!.value)
            currentNode = currentNode?.previous
        }
        return reverserdList
    }
}

// MARK: - LinkedList + CustomStringConvertible
extension LinkedList: CustomStringConvertible {
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

// MARK: - ListNodeIterator
public struct ListNodeIterator<T>: IteratorProtocol {
    public typealias Element = T

    private var head: ListNode<Element>?

    fileprivate init(head: ListNode<T>?) {
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

// MARK: - LinkedList + Sequence
extension LinkedList: Sequence {
    public typealias Iterator = ListNodeIterator<T>

    public func makeIterator() -> Iterator {
        return Iterator(head: head)
    }
}

// MARK: - LinkedList + ExpressibleByArrayLiteral
extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()
        
        for element in elements {
            self.append(element)
        }
    }
}

// MARK: - LinkedList to Array<T>
extension LinkedList {
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
