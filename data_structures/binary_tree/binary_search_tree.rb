require File.join(File.dirname(__FILE__), "binary_tree")

# BinarySearchTree
#
# Implementation of a simple binary search tree (BST) class in
# Ruby. The BST class inherits from BinaryTree, which allows
# traversal of all of the nodes and access to the BinaryTree::Node
# class.
class BinarySearchTree < BinaryTree

  def add(value, node=self.root)

    if @root.nil?
      @root = Node.new( value )
      return
    end

    if (value <= node.value)
      if node.has_left_child?
        add(value, node.left_child)
      else
        node.add_left_child( value )
      end

    elsif (value > node.value)
      if node.has_right_child?
        add(value, node.right_child)
      else
        node.add_right_child( value )
      end
    end
  end

  def contains?( value, node = self.root )
    return false if node.nil?
    return true  if (node.value == value)

    if (value <= node.value)
      return contains?(value, node.left_child)

    elsif (value > node.value)
      return contains?(value, node.right_child)
    end
  end

  def inspect
    %Q[#<BinarySearchTree:0x#{'%x' % (self.object_id << 1)}>]
  end

end


