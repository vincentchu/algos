require "../../data_structures/binary_tree/binary_tree"

# Problem: Common Ancestor of two nodes
#
# Design an algorithm and write code to find the first
# common ancestor of two nodes in a binary tree Avoid
# storing additional nodes in a data structure
#
# NOTE: This is not necessarily a binary search tree
#
# Solution: Recursively walk tree and stop whenever the
# two nodes are on different sides. Given any two nodes,
# the node that is the common ancestor of the two is the
# first node, measured from the tree's root, where one
# node is in the left subtree, and the other is in the
# right subtree.
#
# To solve, recursively descend down the tree until you
# reach a node where one of the input nodes is on the left
# and the other is on the right. To determine which side
# the node is on, just take that node, and ascend the
# tree via the node's parents until you reach the
# candidate ancestor.

def common_ancestor(root, n1, n2)
  side1 = child_side_of(root, n1)
  side2 = child_side_of(root, n2)

  return root if (side1 != side2)

  if (side1 == :left)
    return common_ancestor(root.left_child, n1, n2)
  else
    return common_ancestor(root.right_child, n1, n2)
  end
end

def child_side_of(root, node)
  curr_node = node

  while (curr_node.parent != root)
    curr_node = curr_node.parent
  end

  (curr_node == root.left_child) ? :left : :right
end

# Create the following tree:
#
#         10
#        /  \
#       9    8
#      / \
#     7   6
#        / \
#       5   11
#             \
#              12
tree = BinaryTree.new(10)
tree.root.add_left_child(9).add_right_child(6).add_right_child(11).add_right_child(12)
tree.root.left_child.add_left_child(7)
tree.root.left_child.right_child.add_left_child(5)
tree.root.add_right_child(8)

# n1 and n2's common ancestor is 9
n1 = tree.root.left_child.right_child.right_child.right_child
n2 = tree.root.left_child.left_child

puts common_ancestor(tree.root, n1, n2).inspect
# => 9

