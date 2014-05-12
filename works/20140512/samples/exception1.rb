# encoding: utf-8

class FizzBuzz

  class Fizz < Exception; end

  class Buzz < Exception; end

  class FizzBuzz < Exception; end

  def self.exec num
    raise FizzBuzz.new if num.modulo(3) == 0 && num.modulo(5) == 0
    raise Fizz.new if num.modulo(3) == 0
    raise Buzz.new if num.modulo(5) == 0
    num
  end

end

[1,2,3,4,5,6,7,15].each do |num|
  begin
    out = FizzBuzz.exec num
  rescue FizzBuzz::Fizz => e
    out = "Fizz!"
  rescue FizzBuzz::Buzz => e
    out = "Buzz!"
  rescue FizzBuzz::FizzBuzz => e
    out = "FizzBuzz!"
  rescue Exception => e
    raise e
  ensure
    p out
  end
end

