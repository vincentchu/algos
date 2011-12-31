# Problem: Finding Anagrams
#
# Given a dictionary of English words, return the set of
# all words grouped into subsets of words that are all
# anagrams of each other
#
# Solution: Use a hash table
#
# Two words are anagrams if they contain the exact same
# number of letters. To find anagrams in a dictionary of
# words (implemented below as an array of strings), create
# a unique key that represents the the letters in the word.
# In this case, it's simply a list of the characters in
# word (e.g., dog and god both map to dgo).

DICTIONARY = %w(god dog sag gas food)

words_by_freq = {}
DICTIONARY.each do |word|
  key = word.scan(/./).sort.join("")

  words_by_freq[key] ||= []
  words_by_freq[key] << word
end

anagrams = []
words_by_freq.each_pair do |key, val|
  anagrams << val
end

puts "Anagrams:"
anagrams.each do |anagram|
  puts anagram.inspect
end

# Anagrams:
# ["god", "dog"]
# ["sag", "gas"]
# ["food"]
