class Array
  def median
    i, j = [0, (self.length-1)]
    mid  = (self.length/2)
    (mid -= 1) if (self.length%2 == 0)

    dest = quicksort_partition(i, j)
    while (dest != mid)
      (dest < mid) ? (i = dest+1) : (j = dest-1)
      dest = quicksort_partition(i, j)
    end

    if (self.length%2 == 0)
      return (self[dest] + self[(dest+1)..(self.length-1)].min)/2.0
    else
      return self[dest]
    end
  end

  private

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

  def swap(i, j)
    self[i], self[j] = self[j], self[i]
  end
end


puts [0,1,2,3,4,5,6,7,8,9,10].median
puts [0,1,2,3,4,5,6,7,8,9].median
