# some improvements of the array class
class Array
  # all distinct ways to pick n items from the array, disregarding duplicates in the array
  # (if an item is in the array twice, it counts as two distinct items for purposes of selecting variations)
  def variations(n)
    (0...self.length**n).map do |selection|
      n.times.map do
        i = selection % self.length
        selection /= self.length
        self[i]
      end
    end
  end

  # all the ways to build a tree using the items in the array as leaves
  # the optional parameter is a range of integers greater than 1 indicating the range of possible branches under any node
  # by default trees only branch binarily
  # e.g., the binary trees of [ a, b, c ] are [ a, [ b, c ] ] and [ [ a, b ], c ]; the binary trees of [ a, b ] and [a] are the arrays themselves 
  def n_ary_trees(range=2..2, minimize=true)
    raise "Range parameter expected" unless range.is_a? Range
    min = range.first.to_i
    raise "minimum branches must be at least 2" unless min > 1
    max = range.last.to_i
    max -= 1 if range.exclude_end?
    raise "maximum branches less than minimum branches" if max < min
    return [] if empty?

    # a lambda so we can do recursion without sticking private methods in Array

    # all n-way branches of a
    nwb = -> (a, n) do
      n = a.length if n > a.length
      if n == 1
        [a]
      else
        rv = []
        (1..( a.length - n + 1 )).each do |i|
          a1 = a[0...i]
          r = n  - 1
          nwb.call( a[i..-1], r ).each do |branches|
            branches = [branches] if r == 1
            rv << [a1.dup] + branches
          end
        end
        rv
      end
    end

    # faux method for recursively making n-ary trees
    nt = -> (a) do
      if a.length <= min
        [a]
      else
        rv = []
        (min..( a.length < max ? a.length : max )).each do |branchiness|
          nwb.call( a, branchiness ).each do |part|
            head, *tail = part.map{ |a2| nt.call a2 }
            if tail.any?
              head = head.map{ |t| [t] }
              tail.each do |nxt|
                h = []
                head.each do |a1|
                  nxt.each do |a2|
                    h << a1 + [a2]
                  end
                end
                head = h
              end
            end
            rv += head
          end
        end
        rv
      end
    end

    trees = nt.(self)

    if minimize
      m = -> (t) do
        if t.is_a? Array
          if t.length == 1
            m.call( t[0] )
          else
            t.map{ |t2| m.call t2 }
          end
        else
          t
        end
      end

      m.call trees
    else
      trees
    end
  end
end