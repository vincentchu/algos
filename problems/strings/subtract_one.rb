def subtract_one(str)
  digits = str.chars.collect(&:to_i)
  li     = digits.length-1

  if digits[li] == 0
    carry = true
    digits[li] = 9
  else
    carry = false
    digits[li] -= 1
  end

  li -= 1
  while carry
    digits[li] -= 1
    if digits[li] < 0
      digits[li] += 10
      li -= 1
    else
      carry = false
    end

  end


  digits.join("").gsub(/^0+/, "")
end

num_str = "10000000000"
puts subtract_one(num_str)
puts num_str
