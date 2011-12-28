require "../../data_structures/binary_tree/binary_search_tree"

def time_run(label = "", &block)
  t_strt = Time.now

  yield if block_given?

  t_end  = Time.now
  elapsed = 1000.0 * (t_end - t_strt)


  puts "#{label} Elapsed Time: #{elapsed} ms"
end

# Using Binary Search Trees to search many numbers!
#
# Binary Search Trees (BSTs) can be used to search large collections
# of numbers very efficiently. To demonstrate this, consider the
# following scenario. Suppose you have a collection of 100k numbers and
# would like to know if the collection contains a given number.
#
# In standard ruby, this can be done easily in a few ways:
#
#     array.include?(search)
#     array.select {|val| (val == search) }
#
# However, these methods aren't very efficient since they must loop
# over the entire array element-by-element. In other words, searching
# the array requires O(N) operations. For an array of 100k elements,
# this is ~100k operations.
#
# A more optimal solution uses a BST with the same values, which allows
# the collection to be searched quite rapidly. The reason is that the
# tree structure of a BST allows searches to be completed in O(log n)
# operations, on average (given a reasonably balanced tree). For 100k
# elements, this is only around 17 operations if the tree is perfectly
# balanced!
#
# A few results:
#
#    Array Search Elapsed Time: 2435.826 ms
#    BST   Search Elapsed Time:    2.945 ms
#
# (1000x improvement!)

search = rand                           # A random number to search for
arr    = 100_000.times.collect { rand } # Array of 100k random numbers
bst    = BinarySearchTree.new           # The same random numbers in a BST
arr.each {|n| bst.add(n)}

time_run("Array") {
  100.times {
    arr.select {|val| (val == search) }
  }
}

time_run("BST") {
  100.times {
    bst.contains?(search)
  }
}

