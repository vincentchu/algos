# Boyer-Moore String Search Algorithm
#
# Pure ruby implementation of the Boyer-Moore text searching
# algorithm. According to CLRS, this is pretty much the best
# practical choice when you need to search some text for
# another string (vs. other algorithms like Rabin-Karp or
# Knuth-Morris-Pratt).
#
# How it works
#
# Consider a naive string matching algorithm. Given some text
# T and a pattern P, you could start at the first character of
# T and start matching against P. If a mismatch occurs, just
# shift to the second character (i.e., shift text by 1 character)
# and repeat again and again. This naive algorithm takes O(nm)
# time if n is the length of T and m is the length of P.
#
# The naive algorithm is particularly bad because it does not
# incorporate any information about what the character that
# is mismatched, or what has already been matched.
#
# For instance, consider the following text and pattern. In the
# naive solution, the mismatch occurs at letter d of T (z of P).
# However, shifting by 1 would be wasteful because d doesn't
# even appear in P, making it impossible to match.
#
# T:  ...abcdefgh ...
# P:        zefg
#
# I won't go into it too much since other descriptions are better
# but Boyer-Moore attempts to boost the efficiency of matching by
# skipping ahead greater number of spaces.
class BoyerMoore
  attr_accessor :text
  attr_reader :pattern, :matches

  def initialize( opts )
    @text = opts[:text]
  end

  def search( pattern_str )
    @pattern = Pattern.new( pattern_str )
    @matches = []
    shift    = pattern.length - 1

    while (shift < text.length)

      mismatch_pos, mismatch_char = check_text(shift)

      if (mismatch_pos == -1)
        @matches << shift
        shift += pattern.length
      else
        shift += pattern.shift_by(mismatch_char, mismatch_pos)
      end
    end
  end

  def print_matches(context = 10)
    matches.each do |match_pos|
      match_beg = match_pos - pattern.length + 1
      match_end = match_pos

      match_beg = [0, (match_beg-context)].max
      match_end = [(text.length-1), (match_end+context)].min

      match_text = text[match_beg..match_end]
      match_text.gsub!(pattern.pattern, "\x1b[31;1m#{pattern.pattern}\x1b[0m")
      puts "...#{match_text}..."
    end
  end

  private

  def check_text(shift)
    k     = 0
    p_len = pattern.length - 1

    while (pattern.pattern[p_len-k] == text[shift-k])
      k += 1

      break if (p_len < k)
    end

    if (p_len < k)
      return [-1, nil]
    else
      return [(p_len-k), text[(shift-k)..(shift-k)]]
    end
  end

  class Pattern

    attr_reader :chars, :length, :pattern

    def initialize(pattern)
      @pattern = pattern
      @length  = @pattern.length
      @chars   = {}

      pattern.split(//).each_with_index { |char, pos|
        @chars[char] ||= []
        @chars[char] << pos
      }
    end

    def shift_by(badchar, pos)
      [bad_char_shift(badchar, pos), good_suffix_shift(pos)].max
    end

    def bad_char_shift(badchar, pos)
      pattern_pos = (chars[badchar] || [0]).max

      (pos - pattern_pos)
    end

    def good_suffix_shift(pos)
      good_suffix = pattern[(pos+1)..(length-1)]

      max = 0
      (0..(pos-1)).each do |k|
        max = k if pattern[0..k].end_with?(good_suffix)
      end


      (length - max - 1)
    end
  end
end

LOREM_TEXT = %Q[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.]

searcher = BoyerMoore.new(:text => LOREM_TEXT)

%w(Lorem ipsum ad minim).each do |pattern|
  searcher.search(pattern)
  puts "Matches for '#{pattern}':"
  searcher.print_matches
  puts ""
end

# Matches for 'Lorem':
# ...Lorem ipsum dol...

# Matches for 'aliqua':
# ...ore magna aliqua. Ut enim ...

# Matches for 'ad':
# ...nsectetur adipisicing ...
# .... Ut enim ad minim ven...

# Matches for 'minim':
# ...t enim ad minim veniam, q...
