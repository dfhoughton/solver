require 'array_improvements'
require 'arithmetic_node'

operators = %i[ + - * / ** ].variations(3).freeze

while true
  sought = nil
  while sought.nil?
    puts "give me a number to look for:"
    v = STDIN.gets.chomp.strip
    if v =~ /^\d+$/
      sought = v.to_i
    else
      puts "#{v} does not look like an integer"
    end
  end

  values = nil
  while values.nil?
    puts "give me 4 integers separated by spaces:"
    v = STDIN.gets.chomp.strip
    if v =~ /^\d+(?:\s+\d+){3}$/
      values = v.split.map(&:to_i)
    else
      puts "#{v} does not look like 4 integers separated by spaces"
    end
  end

  puts "looking for ways to make #{sought} out of #{values.inspect}"

  counts = {}

  solutions = []
  values.permutation(4).each do |values|
    operators.each do |operators|
      values.n_ary_trees.each do |left, right|
        n = ArithmeticNode.new left, right, operators.dup
        # puts "#{n} = #{n.to_f}"
        solutions << n if n.to_f == sought
      end
    end
  end

  puts "\nSOLUTIONS:\n"

  solutions.each{ |s| puts s }
  puts "none found" if solutions.empty?

  response = nil
  while true
    puts "\nagain? [Yn]"

    v = STDIN.gets.chomp.strip
    case v.downcase
    when 'y', 'n', ''
      response = v
      break
    else
      "I do not understand '#{v}'. Please answer 'y' or 'n' or simply press return."
    end
    if response
      break
    end
  end
  break if response == 'n'
end
