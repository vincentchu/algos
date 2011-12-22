class Heap
  def initialize
    @array = []
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

vals = (1..10).to_a.sort_by { rand }
# => [7, 4, 2, 1, 3, 8, 6, 5, 9, 10]

h = Heap.new
vals.each {|v| h.push!(v) }

puts 10.times.collect { h.pop! }.inspect
# => [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]





