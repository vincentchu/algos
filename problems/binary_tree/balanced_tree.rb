require "../../data_structures/binary_tree/binary_tree"

# Is a given tree balanced?
#
# Implement a function to check if a tree is balanced For the
# purposes of this question, a balanced tree is defined to be a
# tree such that no two leaf nodes differ in distance from the
# root by more than one.
#
# Solution: Use recursion to traverse down the leaves of the tree,
# keeping track of the current depth and the maximum and minimum
# leaf depth. Whn you hit a leaf (the termination of the recursion),
# check the depth and update the maximium or minimum depth if needed.
# At the top of the call stack (where the recursion is started),
# check the minimum and maximum depth; if the difference between the
# two greater than 1, then the tree isn't balanced!
def is_tree_balanced?( tree )
  min_dist, max_dist = recurse_through_tree(tree.root, 0, (1.0/0.0), -1)
  return ((max_dist - min_dist) <= 1)
end

def recurse_through_tree(node, curr_depth, min_dist, max_dist)
  if node.is_leaf?
    max_dist = [max_dist, curr_depth].max
    min_dist = [min_dist, curr_depth].min
  else
    min_dist, max_dist = recurse_through_tree(node.left_child,  curr_depth+1, min_dist, max_dist) if node.has_left_child?
    min_dist, max_dist = recurse_through_tree(node.right_child, curr_depth+1, min_dist, max_dist) if node.has_right_child?
  end

  [min_dist, max_dist]
end

# Test case 1: A tree with only a root (i.e., no children)
tree = BinaryTree.new(0)

is_tree_balanced?( tree )
# => true

# Test Case 2: A tree with two children:
#   2
#  / \
# 1   3
tree = BinaryTree.new(2)
tree.root.add_left_child(1)
tree.root.add_right_child(3)

p is_tree_balanced?( tree )
# => true

# Test Case 3: An unbalanced tree
#
#       10
#      /  \
#     9    11
#    /
#   8
#  /
# 7
tree = BinaryTree.new(10)
tree.root.add_left_child(9).add_left_child(8).add_left_child(7)
tree.root.add_right_child(11)

is_tree_balanced?( tree )
# => true
