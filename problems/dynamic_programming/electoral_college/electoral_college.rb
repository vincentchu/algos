# Problem: Ties in a Presidential Election
#
# The US President is elected by the members of the Electoral
# College. The number of electors per state and Washington, DC,
# are given in Table 2. All electors from each state as well
# as Washington, DC cast their vote for the same candidate.
#
# Suppose there are two candidates in the presidential
# election. How would you programmatically determine if a tie
# is a possibility? (AFI 3.5)
#
# Solution: Use a dynamic programming algorithm
#
# To solve this problem, we would like to find a set of states
# whose electoral college votes sum to 538/2 = 239 votes.
#
# At first glance, solving this problem seems intractable.
# Naively, we could begin by scanning every possible partition
# until we find a partition of the states that sums to 239 votes.
#
# For N=50 states, we have 2^N possible partitions or 1.13 x 10^15,
# making this a very difficult problem indeed.
#
# However, we can use dynamic programming to solve this problem
# by recognizing two properties:
#
#  1. The problem can be decomposed into subproblems
#  2. The solution has optimal substructure, i.e., an optimal
#     solution can be constructed from the optimal solutions of
#     its subproblem.
#
# In this case, let state i have v_i votes. Without loss of
# generality, let the states be ordered by number of votes in
# ascending order.
#
# Let the matrix M(n, v) be the maximum number of votes that
# can be assembled using only the first n states (1..n) that
# does not exceed v votes. Then a tie is possible if
# M(n, v) == 239 for some choice of n and v.
#
# To compute the matrix M, we note:
#
#   M(0, v) = 0 (Max votes is 0 if no states are used)
#   M(i, 0) = 0 (Max votes is 0 if you can't exceed 0 votes)
#   M(i, v) = M(i-1, v) if (v_i > v) (Votes for state i exceed max)
#   M(i, v) = max { M(i-1, v) , M(i-1, v - v_i) + v_i
#
# These recurrence relations allow us to compute M(i, v) for
# any choice of i and v.
#
# Note: The solution to this problem is really a variant on the
# classic 0-1 Knapsack problem. For a description of this problem,
# please see: http://en.wikipedia.org/wiki/Knapsack_problem
VOTES = {"Ohio" => 20, "North Dakota" => 3, "New Hampshire" => 4, "Minnesota" => 10, "Colorado" => 9, "Alabama" => 9, "Wisconsin" => 10, "Pennsylvania" => 21, "Oklahoma" => 7, "New Mexico" => 5, "Indiana" => 11, "District of Columbia" => 3, "Arkansas" => 6, "West Virginia" => 5, "Illinois" => 21, "South Dakota" => 3, "Michigan" => 17, "Maine" => 4, "Wyoming" => 3, "Vermont" => 3, "Mississippi" => 6, "Kansas" => 6, "Idaho" => 4, "California" => 55, "Virginia" => 13, "New Jersey" => 15, "Connecticut" => 7, "Oregon" => 7, "New York" => 31, "Kentucky" => 8, "Washington" => 11, "Texas" => 34, "Missouri" => 11, "Louisiana" => 9, "Iowa" => 7, "Hawaii" => 4, "Nebraska" => 5, "Utah" => 5, "North Carolina" => 15, "Alaska" => 3, "Tennessee" => 11, "Rhode Island" => 4, "Nevada" => 5, "Florida" => 27, "Arizona" => 10, "South Carolina" => 8, "Montana" => 3, "Massachusetts" => 12, "Maryland" => 10, "Georgia" => 15, "Delaware" => 3}

def votes_in_order
  unless @votes_in_order
    @votes_in_order = VOTES.inject([]) { |arr, state| arr << state; arr }
    @votes_in_order.sort! { |a,b| a[1] <=> b[1] }
  end

  @votes_in_order
end

def matrix(m, n)
  arr = Array.new(m)
  arr.collect! { |a| a = Array.new(n) }

  (0..(m-1)).each do |mm|
    (0..(n-1)).each do |nn|
      arr[mm][nn] = 0
    end
  end

  arr
end

def pretty_print(mat)
  mat.each do |row|
    row.each do |col|
      print sprintf("%6d", col)
    end
    puts ""
  end
end


def is_tie_possible?
  total_votes = VOTES.inject(0) { |sum, h| sum += h[1]; sum }

  return false unless (total_votes % 2 == 0)

  can_tie  = false
  n_votes  = (total_votes / 2)
  n_states = votes_in_order.count
  table    = matrix(n_states+1, n_votes+1)


  (1..n_states).each do |i|
    (1..n_votes).each do |j|

      v_i = votes_in_order[i-1][1]

      if (v_i > j)
        table[i][j] = table[i-1][j]

      else
        vote_ind = (j-v_i)
        tab_val = (vote_ind < 0) ? 0 : table[i-1][vote_ind]

        table[i][j] = [ table[i-1][j], (tab_val + v_i) ].max
      end

      can_tie ||= (table[i][j] == n_votes)
    end
  end

  # pretty_print(table)

  return can_tie
end

puts "Is a tie possible? #{is_tie_possible?}"
# => Is a tie possible? true

