# encoding: utf-8

class TestClass < Hash
  attr_reader :status
  
  def initialize
    @status = 'ok'
  end

  def to_response
    {
      status: @status,
      data: to_hash
    }
  end

  def to_hash
    ret = {}
    self.each do |key, val|
      ret[key] = val
    end
    ret
  end

  def create_data2
    data = self.each_with_object({}) do |(key, val), ret|
      ret[key] = val
    end
  end

end

x = TestClass.new
p x.status
x[:hoge] = "hogehoge"
x[:foo] = "bar"
p x[:foo]
p x.to_response
x.each do |k, v|
  p "#{k}: #{v}"
end
p x.size


p x.class
p x.to_hash.class
