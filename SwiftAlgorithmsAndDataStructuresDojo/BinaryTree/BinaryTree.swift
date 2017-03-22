//
//  BinaryTree.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/20/17.
//
//

import Foundation

// MARK: - BinaryTreeNode
public class BinaryTreeNode<T> {
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

// MARK: - BinaryTree
/*
 `BinaryTree` has no concept of order. Operations such as `insert`, `remove` and `search`
 have no meaning here. These operations are implemented in `BinarySearchTree`, which will
 introduce and leverage the concept of order.
 */
public class BinaryTree<T> {
    var root: BinaryTreeNode<T>?

    public init(root: BinaryTreeNode<T>?) {
        self.root = root
    }

    public convenience init() {
        self.init(root: nil)
    }

    public func traverseInOrder(_ node: BinaryTreeNode<T>?, visit: ((T?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traverseInOrder(node.left, visit: visit)
        visit?(node.data)
        traverseInOrder(node.right, visit: visit)
    }
    
    public func traverseLevelOrder(_ node: BinaryTreeNode<T>?, visit: ((T?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        let queue = Queue<BinaryTreeNode<T>>()
        try? queue.push(node)
        while !queue.isEmpty {
            let node = queue.pop()
            visit?(node?.data)
            if let leftNode = node?.left {
                try? queue.push(leftNode)
            }
            if let rightNode = node?.right {
                try? queue.push(rightNode)
            }
        }
    }

    public func traversePreOrder(_ node: BinaryTreeNode<T>?, visit: ((T?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        visit?(node.data)
        traversePreOrder(node.left, visit: visit)
        traversePreOrder(node.right, visit: visit)
    }

    public func traversePostOrder(_ node: BinaryTreeNode<T>?, visit: ((T?) -> Void)? = nil) {
        guard let node = node else {
            return
        }
        traversePostOrder(node.left, visit: visit)
        traversePostOrder(node.right, visit: visit)
        visit?(node.data)
    }

    public func traverseBreadthFirst(visit: ((T?) -> Void)? = nil) {
        traverseLevelOrder(root, visit: visit)
    }

    public func traverseDepthFirst(visit: ((T?) -> Void)? = nil) {
        traverseInOrder(root, visit: visit)
    }
}

fileprivate extension BinaryTree {
    func dump() -> String {
        var nodes: [String] = []
        traverseInOrder(root) { data in
            let node: String = {
                guard let data = data else {
                    return "-"
                }
                return String(describing: data)
            }()
            nodes.append(node)
        }
        return nodes.joined(separator: ", ")
    }
}

// MARK: - BinaryTree + CustomStringConvertible
extension BinaryTree: CustomStringConvertible {
    public var description: String {
        return dump()
    }
}
