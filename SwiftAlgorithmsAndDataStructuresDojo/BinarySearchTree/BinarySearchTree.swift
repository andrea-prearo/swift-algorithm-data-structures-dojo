//
//  BinarySearchTree.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 3/21/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

/*
 The `key` property of `BinarySearchTreeNode` will be used for ordering the nodes.
 This requires `key` to be of `Comparable` type so we can define an ordering for the nodes.
 */
public class BinarySearchTreeNode<K: Comparable, T: Equatable> {
    var key: K
    var value: T
    var left: BinarySearchTreeNode<K, T>? = nil
    var right: BinarySearchTreeNode<K, T>? = nil
    var parent: BinarySearchTreeNode<K, T>? = nil

    public init(key: K, value: T) {
        self.key = key
        self.value = value
    }
}

// MARK: - BinarySearchTreeNode + CustomStringConvertible
extension BinarySearchTreeNode: CustomStringConvertible {
    public var description: String {
        return "[\(key), \(value)]"
    }
}

// MARK: - BinarySearchTreeNode + Equatable
extension BinarySearchTreeNode: Equatable {}

public func ==<K: Comparable, T: Equatable>(lhs: BinarySearchTreeNode<K, T>, rhs: BinarySearchTreeNode<K, T>) -> Bool {
    guard lhs.key == rhs.key, lhs.value == lhs.value else {
        return false
    }
    return true
}

// MARK: - BinarySearchTree: Lifecycle and Traversal
/*
 `BinarySearchTree` requires the concept of order. This is the reason why the generic
 type `K` has to be `Comparable`. We need to be able to compare the data of each node to
 implement operations such as `insert`, `remove` and `search`.
 */
public class BinarySearchTree<K: Comparable, T: Equatable> {
    var root: BinarySearchTreeNode<K, T>?

    public init(root: BinarySearchTreeNode<K, T>?) {
        self.root = root
    }

    public convenience init() {
        self.init(root: nil)
    }

    public convenience init(array: [BinarySearchTreeNode<K, T>]) {
        self.init(root: nil)

        for node in array {
            insert(newNode: node)
        }
    }

    public convenience init(arrayLiteral elements: BinarySearchTreeNode<K, T>...) {
        self.init(root: nil)

        for element in elements {
            insert(newNode: element)
        }
    }

    public func traverseInOrder(_ node: BinarySearchTreeNode<K, T>?,
                                visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traverseInOrder(node.left, visit: visit)
        visit?(node)
        traverseInOrder(node.right, visit: visit)
    }

    public func traverseLevelOrder(_ node: BinarySearchTreeNode<K, T>?,
                                   visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        let queue = Queue<BinarySearchTreeNode<K, T>>()
        try? queue.push(node)
        while !queue.isEmpty {
            let node = queue.pop()
            visit?(node)
            if let leftNode = node?.left {
                try? queue.push(leftNode)
            }
            if let rightNode = node?.right {
                try? queue.push(rightNode)
            }
        }
    }

    public func traversePreOrder(_ node: BinarySearchTreeNode<K, T>?,
                                 visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        visit?(node)
        traversePreOrder(node.left, visit: visit)
        traversePreOrder(node.right, visit: visit)
    }

    public func traversePostOrder(_ node: BinarySearchTreeNode<K, T>?,
                                  visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traversePostOrder(node.left, visit: visit)
        traversePostOrder(node.right, visit: visit)
        visit?(node)
    }

    public func traverseBreadthFirst(visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        traverseLevelOrder(root, visit: visit)
    }

    public func traverseDepthFirst(visit: ((BinarySearchTreeNode<K, T>?) -> Void)? = nil) {
        traverseInOrder(root, visit: visit)
    }
}

// MARK: - BinarySearchTree: Order-based operations
public extension BinarySearchTree {
    public func search(_ node: BinarySearchTreeNode<K, T>?, key: K) -> BinarySearchTreeNode<K, T>? {
        guard let node = node else {
            return nil
        }
        if node.key == key {
            return node
        }
        if key <= node.key {
            return search(node.left, key: key)
        } else {
            return search(node.right, key: key)
        }
    }

    public func minimum(_ node: BinarySearchTreeNode<K, T>? = nil) -> BinarySearchTreeNode<K, T>? {
        var target = (node == nil) ? root : node
        while target?.left != nil {
            target = target?.left
        }
        return target
    }

    public func maximum(_ node: BinarySearchTreeNode<K, T>? = nil) -> BinarySearchTreeNode<K, T>? {
        var target = (node == nil) ? root : node
        while target?.right != nil {
            target = target?.right
        }
        return target
    }

    public func insert(newNode: BinarySearchTreeNode<K, T>) {
        insert(key: newNode.key, value: newNode.value)
    }

    public func insert(key: K, value: T) {
        var leaf: BinarySearchTreeNode<K, T>? = nil
        var node = root
        while node != nil {
            leaf = node
            if key <= node!.key {
                node = node!.left
            } else {
                node = node!.right
            }
        }
        let newNode = BinarySearchTreeNode(key: key, value: value)
        guard let target = leaf else {
            root = newNode
            return
        }
        newNode.parent = target
        if key <= target.key {
            target.left = newNode
        } else {
            target.right = newNode
        }
    }

    public func remove(node: BinarySearchTreeNode<K, T>) {
        if node.left == nil {
            transplant(source: node, dest: node.right)
            return
        } else if node.right == nil {
            transplant(source: node, dest: node.left)
            return
        }
        guard let target = minimum(node.right) else {
            return
        }
        if target.parent != node {
            transplant(source: target, dest: target.right)
        }
        transplant(source: node, dest: target)
        target.left = node.left
        target.left?.parent = target
    }

    public subscript(key: K) -> BinarySearchTreeNode<K, T>? {
        return search(root, key: key)
    }
}

// MARK: - Private Methods
fileprivate extension BinarySearchTree {
    func dump() -> String {
        var nodeDumps: [String] = []
        traverseInOrder(root) { node in
            let nodeDump: String = {
                guard let node = node else {
                    return "-"
                }
                return node.description
            }()
            nodeDumps.append(nodeDump)
        }
        return nodeDumps.joined(separator: ", ")
    }

    func transplant(source: BinarySearchTreeNode<K, T>, dest: BinarySearchTreeNode<K, T>?) {
        if source.parent == nil {
            root = dest
        } else if source == source.parent?.left {
            source.parent?.left = dest
        } else {
            source.parent?.right = dest
        }
        dest?.parent = source.parent
    }
}

// MARK: - BinarySearchTree + CustomStringConvertible
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        return dump()
    }
}

// MARK: - BinarySearchTree to Array
extension BinarySearchTree {
    var array: [BinarySearchTreeNode<K, T>] {
        var nodes: [BinarySearchTreeNode<K, T>] = []
        traverseInOrder(root) { node in
            if let node = node {
                nodes.append(node)
            }
        }
        return nodes
    }
}

// MARK: - BinarySearchTree + Equatable
extension BinarySearchTree: Equatable {}

public func ==<K: Comparable, T: Equatable>(lhs: BinarySearchTree<K, T>, rhs: BinarySearchTree<K, T>) -> Bool {
    return lhs.array == rhs.array
}
