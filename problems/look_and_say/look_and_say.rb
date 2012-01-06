# Problem: Look and Say
#
# See http://en.wikipedia.org/wiki/Look-and-say_sequence for
# a description of the look and say sequence.
#
# Write a function that creates the first n terms of a look
# and say sequence, starting from a given number. (ccheever)
#
# Solution: See below
def look_and_say(init, n)

  init_arr = init.to_s.split(//).collect(&:to_i)

  n.times do
    puts init_arr.join("")

    next_arr = []

    count = 0
    (0..(init_arr.length-2)).each do |i|

      count += 1

      if (init_arr[i+1] != init_arr[i])
        next_arr << count
        next_arr << init_arr[i]

        count = 0
      end
    end

    next_arr << (count+=1)
    next_arr << init_arr.last

    init_arr = next_arr
  end
end

look_and_say(1, 10)
# 1
# 11
# 21
# 1211
# 111221
# 312211
# 13112221
# 1113213211
# 31131211131221
# 13211311123113112211
