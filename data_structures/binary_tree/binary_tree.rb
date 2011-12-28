# BinaryTree
#
# Implementation of a BinaryTree in ruby. This is a basic class
# from which other, more complicated classes may be constructed
# (e.g., BinarySearchTrees). The class contains a class that
# represents a node in the binary tree (BinaryTree::Node). This
# class has instance methods for choosing left and right children,
# adding left or right children, etc.. The BinaryTree::Node class
# also implements the comparable method <=> allowing the values
# between nodes to be compared
#
# The BinaryTree class contains methods traversing the tree
# recursively in different orders (depth-first and breadth-first
# traversals). It also implements an :each method using inorder
# traversal of the nodes which allows the inclusion of the
# Enumerable module.
class BinaryTree

  include Enumerable

  attr_reader :root

  def initialize(value = nil)
    @root = value.nil? ? nil : Node.new( value )
  end

  # Traverse the nodes in preorder. In other words, traverse
  # the root, then left, then right subtrees. This is a
  # depth-first traversal.
  def nodes_preorder(node = self.root, &block)
    yield( node ) if block_given?
    nodes_preorder(node.left_child, &block)  if node.has_left_child?
    nodes_preorder(node.right_child, &block) if node.has_right_child?
  end

  # Traverse the nodes inorder. This means left subtree, root,
  # then right subtrees. If the binary tree is also a binary
  # search tree, this will return the nodes in their proper order.
  # This is a depth-first traversal.
  def nodes_inorder(node = self.root, &block)
    nodes_inorder(node.left_child, &block) if node.has_left_child?

    yield( node ) if block_given?

    nodes_inorder(node.right_child, &block) if node.has_right_child?
  end

  # Traverse the nodes in postorder. This means left subtree, right
  # subtree, then root. This is a depth-first traversal.
  def nodes_postorder(node = self.root, &block)
    nodes_postorder(node.left_child, &block) if node.has_left_child?
    nodes_postorder(node.right_child, &block) if node.has_right_child?
    yield( node ) if block_given?
  end

  # Traverse the nodes in breadth-first fashion, or level-by-level
  # ordering.
  def nodes_breadthfirst(node = self.root, &block)
    @nodes = []
    iterate_breadthfirst(node, &block)
  ensure
    @nodes = nil
  end

  def is_balanced?
    min_dist, max_dist = find_max_min_depth(self.root, 0, (1.0/0.0), -1)

    return ((max_dist - min_dist) <= 1)
  end

  def inspect
    %Q[#<BinaryTree:0x#{'%x' % (self.object_id << 1)}>]
  end

  def each(&block)
    nodes_inorder(&block)
  end

  private

  def find_max_min_depth(node, curr_depth, min_dist, max_dist)
    if node.is_leaf?
      max_dist = [max_dist, curr_depth].max
      min_dist = [min_dist, curr_depth].min
    else
      min_dist, max_dist = recurse_through_tree(node.left_child,  curr_depth+1, min_dist, max_dist) if node.has_left_child?
      min_dist, max_dist = recurse_through_tree(node.right_child, curr_depth+1, min_dist, max_dist) if node.has_right_child?
    end

    [min_dist, max_dist]
  end

  def iterate_breadthfirst(node, &block)

    yield(node) if block_given?

    @nodes << node.left_child  if node.has_left_child?
    @nodes << node.right_child if node.has_right_child?

    node = @nodes.shift

    iterate_breadthfirst(node, &block) unless node.nil?
  end

  class Node
    attr_accessor :value, :lchild, :rchild, :parent

    NodeAlreadyExists = Class.new( StandardError )

    def initialize( value, parent = nil )
      @value  = value
      @parent = parent
      @lchild = @rchild = nil
    end

    def <=>(node)
      self.value <=> node.value
    end

    def add_left_child( value )
      add_child(:lchild, value)
    end

    def add_right_child( value )
      add_child(:rchild, value)
    end

    def has_left_child?
      !lchild.nil?
    end

    def has_right_child?
      !rchild.nil?
    end

    def left_child
      lchild
    end

    def right_child
      rchild
    end

    def is_leaf?
      (left_child.nil? && right_child.nil?)
    end

    def inspect
      %Q[#<BinaryTree::Node:0x#{'%x' % (self.object_id << 1)} @value=#{value.inspect}>]
    end

    def to_s
      inspect
    end

    private

    def add_child(side, value)
      raise NodeAlreadyExists unless self.send(side).nil?

      self.send("#{side}=".to_sym, Node.new(value, self))

      self.send(side)
    end
  end
end



