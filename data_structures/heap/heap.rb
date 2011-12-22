# >> Heap
# 
# A Heap or Max heap is a data structure based on a tree that satisfies the
# Heap property:
#
#     If K is a child of J, then val(J) >= val(K)
#
# In other words, the value of the parent node is always greater than or equal
# to the value of its children. Because of this property, the root of the tree
# will *always* be the largest value stored in the heap.
#
# Closely related is the concept of a Min heap, or a heap where the children
# are always larger than the parent node; in this case, the root node contains
# the *smallest* value stored in the heap.
#
# Basic Heap Operations
#
# A heap typically implements the following operations:
#
#  - max: Returns the maxmimum value currently stored in the heap
#  - push: Push a new value into the heap 
#  - remove_max: Remove the root (max value)
#
# Note that after pushing or popping a value, the heap must be rebalanced to
# satisfy the heap propery.
#
# Uses
#
# A heap can be used in a variety of places, including sorting algorithms
# (Heap sort, e.g.), finding large or small values in a large collection of
# values. The classical application, however, is in a priority queue.
#
# Say you have a large number of jobs, each with a priority. If you stuff them
# into a heap, then the heap ensures that the highest priority item is always
# at the root. Querying for the object with the highest priority is O(1) or
# constant time, which means it's always available.
#
# Implementation
#
# The implementation below implements a heap as a *binary heap*. This is a very
# nice and elegant implementation of a heap that uses a simple array (@array)
# to store the values stored in the heap.
#
# Briefly, the tree structure (2 children / parent) is represented in the
# following way (hard to visualize). The root node is always stored at index 0.
# Given a node, indexed by n, its two children will be 2n+1 and 2n+2. So, the
# two children of the root are 1 and 2 (2*0+1, 2*0+2). Their children, respectively,
# are 3 and 4, and 5 and 6.
#
# Returning the max is easy; just return the first value in the array. When
# pushing, just add the value to the end of the array. Then, call up_heapify! to
# shuffle the newly-added value up the tree until the heap property is satisfied.
# If the new value is the new maximum, it will get shuffled all the way up the tree
# until it becomes the new root.
#
# When removing the root, or popping, pop off the root node and swap in the very
# last element of the tree. Since the last element of the tree is probably smaller
# then elements below it, shuffle it down by calling down_heapify! until the heap
# propery is again satisfied. Both pushing and popping are O(log n) operations.
#
# References
#
# http://en.wikipedia.org/wiki/Binary_heap

class Heap
  def initialize
    @array = []
  end

  def length
    @array.length
  end

  def to_a
    @array
  end

  def max
    @array[0]
  end

  def push!(val)
    @array << val
    up_heapify!
  end

  def pop!
    if (@array.length == 1)
      return @array.pop
    else
      old_max = max
      last_val = @array.pop
      @array[0] = last_val

      down_heapify!

      old_max
    end
  end

  alias :remove_max :pop!

  private

  def children(index)
    [2*index.to_i + 1, 2*index.to_i + 2]
  end

  def parent(index)
    ((index.to_i) -1)/2
  end

  def swap!(i, j)
    i_val = @array[i]
    @array[i] = @array[j]
    @array[j] = i_val
  end

  def parent_is_greater?( index )
    (@array[ parent(index) ] >= @array[ index ])
  end

  def index_of_child_greater_than(index)
    i_left, i_right = children(index)
    return nil if (i_left >= @array.length)

    val_parent = @array[ index ]
    val_left   = @array[ i_left ]
    val_right  = (@array[ i_right ] || val_parent)
    max_val    = [val_parent, val_left, val_right].max

    if (max_val == val_parent)
      return nil
    else
      return (max_val == val_left) ? i_left : i_right
    end
  end

  def down_heapify!
    i = 0
    until (i_child = index_of_child_greater_than(i)).nil?
      swap!(i, i_child)
      i = i_child
    end
  end

  def up_heapify!
    i_last = @array.length - 1

    until ( (i_last == 0) || parent_is_greater?(i_last) )
      swap!( parent(i_last), i_last )
      i_last = parent(i_last)
    end
  end
end


# # Create an array of integers 1-10, randomly shuffled
# vals = (1..10).to_a.sort_by { rand }
# # => [7, 4, 2, 1, 3, 8, 6, 5, 9, 10]

# # Push these values onto a heap
# h = Heap.new
# vals.each {|v| h.push!(v) }

# # Pop them off in successing. This should pop them off in reverse-order
# puts 10.times.collect { h.pop! }.inspect
# # => [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]





