#!/usr/bin/ruby

n=ARGV.first

puts "Input:  #{n}"

begin
  n_sqrt = Math.sqrt(n).to_i
  raise if (n_sqrt * n_sqrt) != n.to_i
rescue
  puts "Error: input should be a perfect square number"
  exit -1
end

# mathematicaly, zero is perfect square number,
# because sqrt(0) == 0, and 0*0 == 0

if n_sqrt.zero?
  puts "Output:" # I just print zero size matrix :)
  exit 0
end

# n is the size of the square
# notice that a caller should ensure that n is valid - KISS
def counter_clockwise_spiral_square(n)
  if 1 == n
    return [[1]]
  else
    matrix = counter_clockwise_spiral_square(n-1)
    sequence = (((n-1)*(n-1)+1)..n*n).to_a

    if n.odd?
      matrix.each{ |array| array.unshift(sequence.shift)}
      matrix << sequence
    else
      #can be done without reverse, but "Premature optimization is the root of all evil"
      matrix.reverse.each{ |array| array << sequence.shift }
      matrix.unshift sequence.reverse
    end
    return matrix
  end
end

matrix = counter_clockwise_spiral_square(n_sqrt)

cell_width = n.to_s.size

matrix.each_with_index do |array, index|
  print 0 == index ? "Output: " : " "*8
  array.each do |element|
    width = element.to_s.size
    print " " * (cell_width-width) + element.to_s
    print " "
  end
  print "\n"
end

exit 0
