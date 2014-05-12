# encoding: utf-8

class FizzBuzz

  class Fizz < Exception
  end

  class Buzz < Exception
  end

  class FizzBuzz < Exception
  end

  def self.exec num
    raise FizzBuzz.new if num.modulo(3) == 0 && num.modulo(5) == 0
    raise Fizz.new if num.modulo(3) == 0
    raise Buzz.new if num.modulo(5) == 0
    p "*** #{num} ***"
  end

end

[1,2,3,4,5,6,"x",7,15].each do |num|
  begin
    FizzBuzz.exec num
  rescue FizzBuzz::Fizz => e
    p "Fizz!"
  rescue FizzBuzz::Buzz => e
    p "Buzz!"
  rescue FizzBuzz::FizzBuzz => e
    p "FizzBuzz!"
  rescue Exception => e
    p e.message
    break
  end
end

