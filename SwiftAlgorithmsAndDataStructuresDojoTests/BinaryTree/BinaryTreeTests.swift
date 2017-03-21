//
//  BinaryTreeTests.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/20/17.
//
//

import XCTest
@testable import SwiftAlgorithmsAndDataStructuresDojo

class BinaryTreeTests: XCTestCase {
    static let inOrder: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    static let preOrder: [Character] = ["F", "B", "A", "D", "C", "E", "G", "I", "H"]
    static let postOrder: [Character] = ["A", "C", "E", "D", "B", "H", "I", "G", "F"]
    static let levelOrder: [Character] = ["F", "B", "G", "A", "D", "I", "C", "E", "H"]

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

    func testTraverseInOrder() {
        var nodes: [Character] = []
        tree.traverseInOrder(tree.root) { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.inOrder)
    }
    
    func testTraverseLevelOrder() {
        var nodes: [Character] = []
        tree.traverseLevelOrder(tree.root) { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.levelOrder)
    }

    func testTraversePreOrder() {
        var nodes: [Character] = []
        tree.traversePreOrder(tree.root) { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
            return
        }
        XCTAssertEqual(nodes, BinaryTreeTests.preOrder)
    }

    func testTraversePostOrder() {
        var nodes: [Character] = []
        tree.traversePostOrder(tree.root) { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.postOrder)
    }

    func testTraverseBreadthFirst() {
        var nodes: [Character] = []
        tree.traverseBreadthFirst() { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.levelOrder)
    }

    func testTraverseDepthFirst() {
        var nodes: [Character] = []
        tree.traverseDepthFirst() { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            nodes.append(strongSelf.dataToString(data))
        }
        XCTAssertEqual(nodes, BinaryTreeTests.inOrder)
    }
}

fileprivate extension BinaryTreeTests {
    func dataToString(_ data: Character?) -> Character {
        let node: Character = {
            guard let data = data else {
                return "-"
            }
            return data
        }()
        return node
    }
}
