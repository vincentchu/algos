# LinkedList
#
# This is a Ruby implementation of a double-linked list. The class
# LinkedList::Node represents a node of the linked list; its instance
# variables @next and @prev hold references to the next and previous node.
# The class LinkedList wraps the entire class and provides instance
# methods for push/pop, unshift/shift, and iterating over each node
class LinkedList

  attr_reader :head, :tail

  def initialize( data )
    @head = @tail = Node.new( data )
  end

  def push( data )
    n = Node.new( data )

    @tail.next = n
    n.prev     = @tail
    @tail      = n

    @tail
  end

  def pop
    tail_node      = @tail
    @tail          = tail_node.prev
    @tail.next     = nil
    tail_node.prev = nil

    tail_node
  end

  def unshift( data )
    n = Node.new( data )

    @head.prev = n
    n.hext     = @head
    @head      = n

    @head
  end

  def shift
    head_node      = @head
    @head          = head_node.next
    @head.prev     = nil
    head_node.next = nil

    head_node
  end

  def each_node( &block )
    return if @head.nil?

    curr_node = @head
    until (curr_node.nil?)
      yield(curr_node)

      curr_node = curr_node.next
    end
  end

  class Node
    attr_accessor :data, :next, :prev

    def initialize( data )
      @data = data
      @next = @prev = nil
    end

    def inspect
      %Q[#<LinkedList::Node @next=#{} @prev=#{} @data=#{data.inspect}>]
    end
  end
end
