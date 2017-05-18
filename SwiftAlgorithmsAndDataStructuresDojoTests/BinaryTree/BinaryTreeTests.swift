//
//  BinaryTreeTests.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 3/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class BinaryTreeTests: XCTestCase {
    static let inOrder: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    static let preOrder: [Character] = ["F", "B", "A", "D", "C", "E", "G", "I", "H"]
    static let postOrder: [Character] = ["A", "C", "E", "D", "B", "H", "I", "G", "F"]
    static let levelOrder: [Character] = ["F", "B", "G", "A", "D", "I", "C", "E", "H"]
    static let nodes = [
        BinaryTreeNode<Character>(data: "F"),
        BinaryTreeNode<Character>(data: "B"),
        BinaryTreeNode<Character>(data: "G"),
        BinaryTreeNode<Character>(data: "A"),
        BinaryTreeNode<Character>(data: "D"),
        BinaryTreeNode<Character>(data: "C"),
        BinaryTreeNode<Character>(data: "E"),
        BinaryTreeNode<Character>(data: "I"),
        BinaryTreeNode<Character>(data: "H")
    ]

    lazy var tree: BinaryTree<Character> = {
        let root = BinaryTreeNode<Character>(data: "F")
        root.left = BinaryTreeNode<Character>(data: "B")
        root.right = BinaryTreeNode<Character>(data: "G")
        root.left?.left = BinaryTreeNode<Character>(data: "A")
        root.left?.right = BinaryTreeNode<Character>(data: "D")
        root.left?.right?.left = BinaryTreeNode<Character>(data: "C")
        root.left?.right?.right = BinaryTreeNode<Character>(data: "E")
        root.right?.right = BinaryTreeNode<Character>(data: "I")
        root.right?.right?.left = BinaryTreeNode<Character>(data: "H")
        return BinaryTree<Character>(root: root)
    }()

    func testIsEmpty() {
        XCTAssertTrue(BinaryTree<Int>().isEmpty)
        XCTAssertTrue(BinaryTree<Character>().isEmpty)
    }

    func testNodeEquality() {
        XCTAssertEqual(BinaryTreeTests.nodes.first, tree.root)
        XCTAssertNotEqual(BinaryTreeTests.nodes.last, tree.root)
    }

    func testEquality() {
        let tree1 = BinaryTree<Int>()
        tree1.root = BinaryTreeNode<Int>(data: 2)
        tree1.root?.left = BinaryTreeNode<Int>(data: 1)
        tree1.root?.right = BinaryTreeNode<Int>(data: 3)
        let tree2 = BinaryTree<Int>()
        tree2.root = BinaryTreeNode<Int>(data: 4)
        tree2.root?.left = BinaryTreeNode<Int>(data: 2)
        tree2.root?.right = BinaryTreeNode<Int>(data: 8)
        let tree3 = BinaryTree<Int>()
        tree3.root = BinaryTreeNode<Int>(data: 2)
        tree3.root?.left = BinaryTreeNode<Int>(data: 1)
        tree3.root?.right = BinaryTreeNode<Int>(data: 3)
        XCTAssertEqual(tree1, tree3)
        XCTAssertNotEqual(tree1, tree2)
    }

    func testTraverseInOrder() {
        var nodes: [Character] = []
        tree.traverseInOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.inOrder)
    }

    func testTraverseLevelOrderNil() {
        let tree = BinaryTree<Character>()
        var nodes: [Character] = []
        tree.traverseInOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])
    }

    func testTraverseLevelOrder() {
        var nodes: [Character] = []
        tree.traverseLevelOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.levelOrder)
    }

    func testTraversePreOrder() {
        var nodes: [Character] = []
        tree.traversePreOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
            return
        }
        XCTAssertEqual(nodes, BinaryTreeTests.preOrder)
    }

    func testTraversePostOrder() {
        var nodes: [Character] = []
        tree.traversePostOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.postOrder)
    }

    func testTraverseBreadthFirst() {
        var nodes: [Character] = []
        tree.traverseBreadthFirst { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.levelOrder)
    }

    func testTraverseDepthFirst() {
        var nodes: [Character] = []
        tree.traverseDepthFirst { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.inOrder)
    }

    func testDescription() {
        let description = BinaryTreeTests.inOrder.map { String($0) }.joined(separator: ", ")
        XCTAssertEqual(tree.description, description)
        XCTAssertEqual(BinaryTree<Character>().description, "")
    }
}

fileprivate extension BinaryTreeTests {
    func dump(_ node: BinaryTreeNode<Character>?) -> Character {
        let nodeDump: Character = {
            guard let node = node else {
                return "-"
            }
            return node.data
        }()
        return nodeDump
    }
}
