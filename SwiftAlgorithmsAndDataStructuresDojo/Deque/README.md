Dequeue
=======

Implementation of a Double-ended Queue data structure.

`SimpleDeque` is using an array as the underlying storage mechanism.
Because of this, the `pop` and `pushFront` operations are not optimized:
- The `push` and `popBack` operations require constant time **O(1)** as we are just appending
to the array or removing the last element.
- The `pop` and `pushFront` operations, instead, require linear time **O(n)** because the
array needs to be rearranged after removing the first item and when inserting an
element anywhere but at the end.

`Queue` is an optimized implementation which uses a (doubly) linked list as the underlying
storage mechanism to allow all operations to be executed in constant time **O(1)**.

Operations:
- `push`
- `pushFront`
- `pop`
- `popBack`
- `front`
- `back`
