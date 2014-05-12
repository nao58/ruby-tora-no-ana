# encoding: utf-8

class FizzBuzz

  class FizzBuzzException < Exception; end

  class Fizz < FizzBuzzException
    def message
      'Fizz!'
    end
  end

  class Buzz < FizzBuzzException
    def message
      'Buzz!'
    end
  end

  class FizzBuzz < FizzBuzzException
    def message
      'FizzBuzz!'
    end
  end

  class Zero < Exception
    def message
      'Cannot handle the value zero.'
    end
  end

  def self.exec num
    raise Zero.new if num == 0
    raise FizzBuzz.new if num.modulo(3) == 0 && num.modulo(5) == 0
    raise Fizz.new if num.modulo(3) == 0
    raise Buzz.new if num.modulo(5) == 0
    num
  end

end

def FizzBuzzTest arr
  arr.each do |num|
    begin
      out = FizzBuzz.exec num
    rescue FizzBuzz::Zero => e
      out = "ZERO"
    rescue FizzBuzz::FizzBuzzException => e
      out = e.message
    rescue Exception => e
      raise e
    ensure
      p out
    end
  end
end

FizzBuzzTest [0,1,2,3,4,5,6,7,15,16,"x",18]
