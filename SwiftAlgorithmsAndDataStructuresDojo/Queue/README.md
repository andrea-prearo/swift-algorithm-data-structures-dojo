Queue
=====

Implementation of a Queue (**FIFO**) data structure.

`SimpleQueue` uses an array as the underlying storage mechanism.
Because of this, the `pop` operation is not optimized:
- The `push` operation requires constant time **O(1)** as we are just appending to the array.
- The `pop` operation, instead, requires linear time **O(n)** because the array needs to be rearranged after removing the first item.

`Queue` is an optimized implementation which uses a linked list as the underlying storage mechanism to allow all operations to be executed in constant time **O(1)**.

Operations:
- `push`
- `pop`
- `front`
- `back`
