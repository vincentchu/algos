require "../../data_structures/binary_tree/binary_tree"

# Create a sample Binary Search Tree
#
#         F
#       /   \
#      B     G
#     / \     \
#    A   D     I
#       / \   /
#      C   E H
#
tree = BinaryTree.new('F')
tree.root.add_left_child('B').add_left_child('A')
tree.root.add_right_child('G').add_right_child('I').add_left_child('H')
tree.root.left_child.add_right_child('D').add_left_child('C')
tree.root.left_child.right_child.add_right_child('E')

# Traverse the tree in different orders (in order, pre-order, post-order,
# and breadth-first order).
puts "Nodes in order"
tree.nodes_inorder { |node| print "#{node.value} " }
# => A B C D E F G H I

puts "\nNodes preorder"
tree.nodes_preorder { |node| print "#{node.value} " }
# => F B A D C E G I H

puts "\nNodes postorder"
tree.nodes_postorder { |node| print "#{node.value} "}
# => A C E D B H I G F

puts "\nNodes breadth first"
tree.nodes_breadthfirst { |node| print "#{node.value} " }
# => F B G A D I C E H
