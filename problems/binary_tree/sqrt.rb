def sqrt(n, precision)
  ci = 0.0
  cj = n.to_f
  cm = (ci + cj)/2.0
  iters = 0

  while ((n - (cm*cm)).abs > precision)
    puts "Guess: #{iters} #{cm}"
    if (cm*cm > n)
      cj = cm
    else
      ci = cm
    end

    iters += 1
    cm = (ci + cj)/2.0
  end

  cm
end

n    = 25.0
prec = 1e-16

sqrt_foola = sqrt(n, prec)
sqrt_ruby  = Math.sqrt(n)

puts "By ruby:  #{sqrt_ruby}"
puts "By foola: #{sqrt_foola}"
puts "delta:    #{sqrt_foola - sqrt_ruby}"

