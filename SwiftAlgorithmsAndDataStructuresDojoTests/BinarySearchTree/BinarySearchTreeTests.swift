//
//  BinarySearchTreeTests.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Andrea Prearo on 3/21/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class BinarySearchTreeTests: XCTestCase {
    static let inOrder: [String] = [
        "[23, C]", "[42, B]", "[50, H]", "[56, D]", "[58, I]", "[59, A]", "[69, G]", "[72, J]", "[79, E]", "[90, F]"]
    static let preOrder: [String] = [
        "[59, A]", "[42, B]", "[23, C]", "[56, D]", "[50, H]", "[58, I]", "[79, E]", "[69, G]", "[72, J]", "[90, F]"]
    static let postOrder: [String] = [
        "[23, C]", "[50, H]", "[58, I]", "[56, D]", "[42, B]", "[72, J]", "[69, G]", "[90, F]", "[79, E]", "[59, A]"]
    static let levelOrder: [String] = [
        "[59, A]", "[42, B]", "[79, E]", "[23, C]", "[56, D]", "[69, G]", "[90, F]", "[50, H]", "[58, I]", "[72, J]"]
    static let nodes = [
        BinarySearchTreeNode(key: 59, value: "A"),
        BinarySearchTreeNode(key: 42, value: "B"),
        BinarySearchTreeNode(key: 23, value: "C"),
        BinarySearchTreeNode(key: 56, value: "D"),
        BinarySearchTreeNode(key: 79, value: "E"),
        BinarySearchTreeNode(key: 90, value: "F"),
        BinarySearchTreeNode(key: 69, value: "G"),
        BinarySearchTreeNode(key: 50, value: "H"),
        BinarySearchTreeNode(key: 58, value: "I"),
        BinarySearchTreeNode(key: 72, value: "J")
    ]

    lazy var tree: BinarySearchTree<Int, String> = {
        let bst = BinarySearchTree<Int, String>()
        for node in BinarySearchTreeTests.nodes {
            bst.insert(newNode: node)
        }
        return bst
    }()

    func testIsEmpty() {
        XCTAssertTrue(BinarySearchTree<Int, Int>().isEmpty)
        XCTAssertTrue(BinarySearchTree<Int, String>().isEmpty)
    }

    func testNodeEquality() {
        XCTAssertEqual(BinarySearchTreeTests.nodes.first, tree.root)
        XCTAssertNotEqual(BinarySearchTreeTests.nodes.last, tree.root)
    }

    func testInitFromArray() {
        let newTree = BinarySearchTree(array: BinarySearchTreeTests.nodes)
        XCTAssertEqual(newTree, tree)
    }

    func testExpressibleByArrayLiteral() {
        let tree = BinarySearchTree<Int, String>()
        let nodes = [
            BinarySearchTreeNode(key: 32, value: "ATP"),
            BinarySearchTreeNode(key: 4, value: "FTJ"),
            BinarySearchTreeNode(key: 75, value: "ORN"),
            BinarySearchTreeNode(key: 42, value: "THA")
        ]
        for node in nodes {
            tree.insert(newNode: node)
        }
        let newTree = BinarySearchTree(arrayLiteral: BinarySearchTreeNode(key: 32, value: "ATP"),
                                       BinarySearchTreeNode(key: 4, value: "FTJ"),
                                       BinarySearchTreeNode(key: 75, value: "ORN"),
                                       BinarySearchTreeNode(key: 42, value: "THA"))
        XCTAssertEqual(newTree, tree)
    }

    func testTraverseInOrder() {
        var nodes: [String] = []
        tree.traverseInOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.inOrder)
    }

    func testTraverseInOrderNil() {
        let tree = BinarySearchTree<Int, String>()
        var nodes: [String] = []
        tree.traverseInOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])

        nodes = []
        tree.traverseInOrder(nil) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])
    }

    func testTraverseLevelOrder() {
        var nodes: [String] = []
        tree.traverseLevelOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.levelOrder)
    }

    func testTraverseLevelOrderNil() {
        let tree = BinarySearchTree<Int, String>()
        var nodes: [String] = []
        tree.traverseLevelOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])

        nodes = []
        tree.traverseLevelOrder(nil) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])
    }

    func testTraversePreOrder() {
        var nodes: [String] = []
        tree.traversePreOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
            return
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.preOrder)
    }

    func testTraversePreOrderNil() {
        let tree = BinarySearchTree<Int, String>()
        var nodes: [String] = []
        tree.traversePreOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
            return
        }
        XCTAssertEqual(nodes, [])

        nodes = []
        tree.traversePreOrder(nil) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])
    }

    func testTraversePostOrder() {
        var nodes: [String] = []
        tree.traversePostOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.postOrder)
    }

    func testTraversePostOrderNil() {
        let tree = BinarySearchTree<Int, String>()
        var nodes: [String] = []
        tree.traversePostOrder(tree.root) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])

        nodes = []
        tree.traversePostOrder(nil) { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, [])
    }

    func testTraverseBreadthFirst() {
        var nodes: [String] = []
        tree.traverseBreadthFirst { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.levelOrder)
    }

    func testTraverseDepthFirst() {
        var nodes: [String] = []
        tree.traverseDepthFirst { [weak self] node in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dump(node))
        }
        XCTAssertEqual(nodes, BinarySearchTreeTests.inOrder)
    }

    func testDescription() {
        XCTAssertEqual(tree.description, BinarySearchTreeTests.inOrder.joined(separator: ", "))
        XCTAssertEqual(BinarySearchTree<Int, String>().description, "")
    }

    func testSearchFailure() {
        XCTAssertEqual(tree.search(tree.root, key: 1), nil)
    }

    func testSearchSuccess() {
        for node in BinarySearchTreeTests.nodes {
            XCTAssertEqual(tree.search(tree.root, key: node.key), node)
        }
    }

    func testMinimum() {
        XCTAssertEqual(tree.minimum(), BinarySearchTreeNode(key: 23, value: "C"))
    }

    func testMaximum() {
        XCTAssertEqual(tree.maximum(), BinarySearchTreeNode(key: 90, value: "F"))
    }

    func testInsert() {
        let tree = BinarySearchTree<Int, String>()
        let nodes = [
            BinarySearchTreeNode(key: 1, value: "A"),
            BinarySearchTreeNode(key: 2, value: "B"),
            BinarySearchTreeNode(key: 3, value: "C"),
            BinarySearchTreeNode(key: 4, value: "D"),
            BinarySearchTreeNode(key: 5, value: "E"),
            BinarySearchTreeNode(key: 6, value: "F"),
            BinarySearchTreeNode(key: 7, value: "G"),
            BinarySearchTreeNode(key: 8, value: "H"),
            BinarySearchTreeNode(key: 9, value: "I")
        ]
        var insertOrder = (0..<nodes.count).map { $0 }
        insertOrder.shuffle()
        _ = (0..<insertOrder.count).map { tree.insert(newNode: nodes[$0]) }
        testSearchSuccess()
    }

    func testRemove() {
        let leftmostLeaf = tree.minimum()!
        tree.remove(node: leftmostLeaf)
        XCTAssertEqual(tree.minimum(), tree.search(tree.root, key: 42))
        let rightmostLeaf = tree.maximum()!
        tree.remove(node: rightmostLeaf)
        XCTAssertEqual(tree.maximum(), tree.search(tree.root, key: 79))
        let leftRightSubtree = tree.search(tree.root, key: 56)!
        tree.remove(node: leftRightSubtree)
        XCTAssertEqual(tree.minimum(), tree.search(tree.root, key: 42))
        tree.remove(node: tree.maximum()!)
        XCTAssertEqual(tree.maximum(), tree.search(tree.root, key: 72))
        tree.remove(node: tree.root!)
        XCTAssertEqual(tree.root, tree.search(tree.root, key: 69))
    }

    func testRemoveLeftSubtree() {
        tree.remove(node: tree.search(tree.root, key: 42)!)
    }

    func testRemoveRightSubtree() {
        tree.remove(node: tree.search(tree.root, key: 79)!)
    }

    func testSubscript() {
        for node in BinarySearchTreeTests.nodes {
            XCTAssertEqual(tree[node.key], node)
        }
    }
}

fileprivate extension BinarySearchTreeTests {
    func dump(_ node: BinarySearchTreeNode<Int, String>?) -> String {
        let nodeDump: String = {
            guard let node = node else {
                return "-"
            }
            return node.description
        }()
        return nodeDump
    }
}
