//
//  BinaryTree.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 3/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

// MARK: - BinaryTreeNode
public class BinaryTreeNode<T: Comparable> {
    var data: T
    var left: BinaryTreeNode<T>? = nil
    var right: BinaryTreeNode<T>? = nil

    public init(data: T) {
        self.data = data
    }
}

// MARK: - BinaryTreeNode + CustomStringConvertible
extension BinaryTreeNode: CustomStringConvertible {
    public var description: String {
        return String(describing: data)
    }
}

// MARK: - BinaryTreeNode + Equatable
extension BinaryTreeNode: Equatable {}

public func ==<T: Equatable>(lhs: BinaryTreeNode<T>, rhs: BinaryTreeNode<T>) -> Bool {
    return lhs.data == rhs.data
}

// MARK: - BinaryTree
/*
 `BinaryTree` has no concept of order. Operations such as `insert`, `remove` and `search`
 have no meaning here. These operations are implemented in `BinarySearchTree`, which will
 introduce and leverage the concept of order.
 */
public class BinaryTree<T: Comparable> {
    var root: BinaryTreeNode<T>?

    public init(root: BinaryTreeNode<T>?) {
        self.root = root
    }

    public convenience init() {
        self.init(root: nil)
    }

    public func traverseInOrder(_ node: BinaryTreeNode<T>?,
                                visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traverseInOrder(node.left, visit: visit)
        visit?(node)
        traverseInOrder(node.right, visit: visit)
    }

    public func traverseLevelOrder(_ node: BinaryTreeNode<T>?,
                                   visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        let queue = Queue<BinaryTreeNode<T>>()
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

    public func traversePreOrder(_ node: BinaryTreeNode<T>?,
                                 visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        visit?(node)
        traversePreOrder(node.left, visit: visit)
        traversePreOrder(node.right, visit: visit)
    }

    public func traversePostOrder(_ node: BinaryTreeNode<T>?,
                                  visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traversePostOrder(node.left, visit: visit)
        traversePostOrder(node.right, visit: visit)
        visit?(node)
    }

    public func traverseBreadthFirst(visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        traverseLevelOrder(root, visit: visit)
    }

    public func traverseDepthFirst(visit: ((BinaryTreeNode<T>?) -> Void)? = nil) {
        traverseInOrder(root, visit: visit)
    }
}

// MARK: - Private Methods
fileprivate extension BinaryTree {
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
}

// MARK: - BinaryTree + CustomStringConvertible
extension BinaryTree: CustomStringConvertible {
    public var description: String {
        return dump()
    }
}

// MARK: - BinaryTree to Array
extension BinaryTree {
    var array: [BinaryTreeNode<T>] {
        var nodes: [BinaryTreeNode<T>] = []
        traverseInOrder(root) { node in
            if let node = node {
                nodes.append(node)
            }
        }
        return nodes
    }
}

// MARK: - BinaryTree + Equatable
extension BinaryTree: Equatable {}

public func ==<T>(lhs: BinaryTree<T>, rhs: BinaryTree<T>) -> Bool {
    return lhs.array == rhs.array
}
