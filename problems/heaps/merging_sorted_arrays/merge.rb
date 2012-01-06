# Problem: Merging Sorted Arrays
#
# You are given 500 files, each containing stock quote information
# for an SP500 company. Each line contains an update of the
# following form:
#
# 1232111 131 B 1000 270
# 2212313 246 S 100 111.01
#
# The first number is the update time expressed as the number of
# milliseconds since the start of the day's trading. Each file
# individaully is sorted by this value. your task is to create a
# single file containing all the updates sorted by the update time.
# The individal files are of the order of 1-100 MB; the combined
# file will be of the order of 5GB.
#
# Design an algorithm that takes the files as described above and
# writes a single file containing the lines appearing in the individual
# files sorted by the update time. The algorithm should use very little
# memory, ideally on the order of a few KB. (AFI 2.10)
#
# Solution: Use a heap to keep track of which file handle to read from
#
# First off, this problem is difficult because of the requirement
# that the process only take a few KB of memory. Because of this
# requirement, a naive solution of simply sorting the numbers in the
# file is out. Moreover, the naive solution is fairly inefficient.
#
# If the total dataset is ~5GB, and each line is approximately 25 bytes,
# then the naive solution would require sorting ~215M values. Sorting
# this many values requires O(n log n) calculations, or somewhere in
# the neighborhood of 6 billion operations. Yikes!
#
# Instead, the solution using heaps is fairly elegant. Since each
# file contains only sorted value, keep track of the value at the
# current read position of each file using a min heap. First, pop the
# top file handle from the heap and begin reading values from this
# file. Each time you read a value, compare the value to the current
# value of the file at the top of the heap (an O(1) operation since
# it's at the top of the heap). If the next value being read off
# the file handle is bigger than the current position of the file
# at the top of the heap, push the file handle back into the heap, and
# pop the root file handle off and begin reading from that. Both
# these steps are only order O(log k) where k is the number of files
# (only ~500 in this example)
#
# This algorithm is pretty fast since all you're keeping track of is
# the file handle and 500 values in a heap. It's also fairly fast,
# requiring O(N) to run, with a bit of a hit if you need to pop
# files in and out of the heap. But this hit is negliglbe if N >> k.

require File.join(File.dirname(__FILE__), "../../../data_structures/heap/heap")

class FileHandle
  attr_reader :handle, :curr_pos

  include Comparable

  def initialize(file_name)
    @handle = File.open( file_name, "r" )
    @curr_pos = self.readline
  end

  def advance
    retval = curr_pos
    @curr_pos = readline

    retval
  end

  def readline
    handle.readline.chomp.to_i
  rescue EOFError
    -1
  end

  def close
    handle.close
  end

  def <=>(file_handle)
    # Flip the typical order of comparison
    # so that the smallest values are "bigger",
    # which converts our max heap into a min heap.
    file_handle.curr_pos <=> curr_pos
  end
end

# First generate a set of test data: 10 files, each with 100 random
# numbers in order
(1..10).each do |i|

  f = File.open("file_#{i}.data", "w")
  t = (rand * 10_000).to_i

  100.times {
    f.puts t
    t += (1_000 * rand).to_i
  }

  f.close
end

files  = Dir["file_*"]
heap   = Heap.new
output = File.open("output.txt", "w") # The final sorted output

files.each {|f| heap.push!( FileHandle.new(f) ) }

loop {
  curr_file = heap.pop!

  if (heap.max.nil?)
    output.puts(curr_file.advance) while (curr_file.curr_pos != -1)

    break

  else
    output.puts(curr_file.advance) while ((curr_file.curr_pos != -1) && (curr_file.curr_pos <= heap.max.curr_pos))
    heap.push!(curr_file) if (curr_file.curr_pos != -1)
  end
}

output.close
