# Find k-smallest integers from an array of N integers
#
# Given an array of N integers in no particular order, what is the fastest
# way to determine which are the smallest k of them?
#
# Solution: Use a heap!
#
# First, the solution of this problem seems easy. Just sort the N-Array, and
# take the first K-values. Indeed, in Ruby, this can be done as a simple
# one-liner:
#
#     solution = n_array.sort.first( k )
#
# However, this is *not* the most optimal. Sorting an array of N-integers
# requires O(N log N). operations. As we'll see below, the solution using a
# heap only requires O(N log k) operations. For k << N, this can result in
# significant savings.
#
# To be more concrete, suppose we're trying to find the smallest 1000 numbers
# from an array of 1 billion numbers. Here's how the two solutions measure up:
#
#     naive:  ~30.0 billion operations
#     heap:   ~ 1.0 billion operations
#
# That's a factor 30x improvement!
require File.join(File.dirname(__FILE__), "../../data_structures/heap/heap")

N = 1000
K = 100

# First create a randomly sorted array of integers from 1-N.
# The end result of this script should be the smallest integers from
# n_array, or integers 1-K.
n_array = (1..N).to_a.sort_by { rand }

# Create the Heap object and push the first value of the N-array into it
heap = Heap.new
heap.push! n_array.shift

# Iterate over the remainder of the N-Array. If the next element is less
# than heap.max, then it should be part of the K-Array. If the K-Array is
# already full (i.e., it contains K-items), then we should remove the largest
# item currently stored before pushing the next integer on.
#
# The complexity goes like this. The outer loop, where we iterate over n_array
# will take N steps. Inside the loop, we do at most two operations: removing
# the max of the heap, and pushing into the heap. Both of these oprations
# take around log k operations. So if we do the outer loop N times, and each
# run through the loop takes at most log k operations, the overall complexity
# is O(N log k)
n_array.each do |int|
  if (int < heap.max)
    heap.remove_max unless (heap.length < K)
    heap.push!( int )
  end
end

puts heap.to_a.sort.inspect
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
#     21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
#     39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
#     57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
#     75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92,
#     93, 94, 95, 96, 97, 98, 99, 100]

