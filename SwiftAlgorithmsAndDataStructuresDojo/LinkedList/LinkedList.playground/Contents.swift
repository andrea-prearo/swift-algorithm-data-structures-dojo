import SwiftAlgorithmsAndDataStructuresDojo

let list = LinkedList<Int>()
list.append(5)
list.append(1)
list.append(-3)

print("list: \(list)")
print("\(list.count) items")
for item in list {
    print("item: \(item)")
}
print("head: \(list.head)")
print("tail: \(list.tail)")
print("reversed: \(list.reversed())")
list.reverse()
print("reverse: \(list)")

print("list: \(list.removeAll())")

let listFromArray = LinkedList<Int>(array: [1, 2, 3, 4])
print("listFromArray: \(listFromArray))")
listFromArray.removeHead()
print("removeHead: \(listFromArray))")

let listFromArrayLiteral = LinkedList(arrayLiteral: 5, 6, 7, 8)
print("list: \(listFromArrayLiteral)")
listFromArrayLiteral.removeTail()
print("removeTail: \(listFromArrayLiteral)")

