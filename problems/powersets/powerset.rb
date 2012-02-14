arr = %w(a b c d)

$powset = []

def gen_powerset( set )
  $powset << set.dup

  (0..(set.length-1)).each do |i|
    n_set = set.dup
    n_set.delete_at(i)
    gen_powerset(n_set)
  end
end

gen_powerset( arr )
$powset.uniq!

puts $powset.inspect

