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

class FileHandle
  attr_reader :handle, :curr_pos

  include Comparable

  def initialize(file_name)
    @handle = File.open( file_name, "r" )
    @curr_pos = self.readline
  end

  def advance
    retval = curr_pos.dup
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
    file_handle.curr_pos <=> curr_pos
  end
end

require File.join(File.dirname(__FILE__), "../../../data_structures/heap/heap")

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

files = Dir["file_*"]
heap = Heap.new

files.each {|f| heap.push!( FileHandle.new(f) ) }





