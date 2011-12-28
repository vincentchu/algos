class BinaryTree

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

  def inspect
    %Q[#<BinaryTree:0x#{'%x' % (self.object_id << 1)}>]
  end

  private

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

