class ArithmeticNode
  attr_reader :left, :right, :operator
  def initialize(left, right, operators)
    @operator = operators.shift
    @left, @right = [ left, right ].map do |v|
      if v.is_a? Array
        self.class.new *v, operators
      else
        v
      end
    end
  end

  def to_s
    if operator == :log
      "log( #{left}, #{right} )"
    else
      "( #{left} #{operator} #{right} )"
    end
  end

  def to_f
    f1, f2 = [ left, right ].map do |v|
      f = v.to_f
      return f if f.nan? || f.infinite?
      f
    end
    if operator == :log
      begin
        Math.log f1, f2
      rescue Math::DomainError
        Float::NAN
      end
    else
      f1.send operator, f2
    end
  end
end