# Problem: Ties in a Presidential Election
#
# The US President is elected by the members of the Electoral
# College. The number of electors per state and Washington, DC,
# are given in Table 2. All electors from each state as well
# as Washington, DC cast their vote for the same candidate.
#
# Suppose there are two candidates in the presidential
# election. How would you programmatically determine if a tie
# is a possibility?
#

# A(w) = max( A(w-1), max_i A(w-w_i) + v_i )

VOTES = {"Ohio"=>20, "North Dakota"=>3, "New Hampshire"=>4, "Minnesota"=>10, "Colorado"=>9, "Alabama"=>9, "Wisconsin"=>10, "Pennsylvania"=>21, "Oklahoma"=>7, "New Mexico"=>5, "Indiana"=>11, "District of Columbia"=>3, "Arkansas"=>6, "West Virginia"=>5, "Illinois"=>21, "South Dakota"=>3, "Michigan"=>17, "Maine"=>4, "Wyoming"=>3, "Vermont"=>3, "Mississippi"=>6, "Kansas"=>6, "Idaho"=>4, "California"=>55, "Virginia"=>13, "New Jersey"=>15, "Connecticut"=>7, "Oregon"=>7, "New York"=>31, "Kentucky"=>8, "Washington"=>11, "Texas"=>34, "Missouri"=>11, "Louisiana"=>9, "Iowa"=>7, "Hawaii"=>4, "Nebraska"=>5, "Utah"=>5, "North Carolina"=>15, "Nebraska "=>0, "Alaska"=>3, "Tennessee"=>11, "Rhode Island"=>4, "Nevada"=>5, "Florida"=>27, "Arizona"=>10, "South Carolina"=>8, "Montana"=>3, "Massachusetts"=>12, "Maryland"=>10, "Georgia"=>15, "Delaware"=>3}


def max_votes(n)
  @max_votes ||= {}

  (n<=0) ? 0 : @max_votes[n]
end

def set_max_vote(n, val)
  @max_votes ||= {}

  @max_votes[n]
end

def vote_array
  @vote_array ||= VOTES.to_a
end

def is_tie_possible?
  total_votes = VOTES.inject(0) { |sum, h| sum += h[1]; sum }

  return false unless (total_votes % 2 == 0)

  half_votes = total_votes / 2

  (1..half_votes).each do |n_votes|
    puts "Check A(#{n_votes})"




    m_vote = [max_votes(n_votes-1), max_with_item].max





  end

  true
end

puts "Is a tie possible? #{is_tie_possible?}"


