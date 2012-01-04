class Array
  def quick_sort!
    quicksort(0, self.length-1)

    self
  end

  def quicksort(p, r)
    if (p < r)
      q = quicksort_partition(p, r)

      quicksort(p, q)
      quicksort(q+1, r)
    end
  end

  def swap(i, j)
    self[i], self[j] = self[j], self[i]
  end

  def quicksort_partition(p, r)
    x = self[p]
    i = p; j = r

    loop {
      j-=1 until (self[j] <= x)
      i+=1 until (self[i] >= x)

      if (i < j)
        swap(i, j)
        puts self.inspect
      else
        return j
      end
    }

  end
end

arr = (0..9).to_a.sort_by { rand }
puts arr.inspect

puts arr.quick_sort!.inspect

puts $n

