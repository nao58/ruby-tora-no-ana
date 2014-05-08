# encoding: utf-8

class TestClass
  attr_reader :status
  
  def initialize
    @status = 'ok'
    @data = {}
  end

  def []= key, val
    @data[key] = val
  end

  def [] key
    @data[key]
  end

  def to_response
    {
      status: @status,
      data: @data
    }
  end

end

x = TestClass.new
p x.status
x[:hoge] = "hogehoge"
x[:foo] = "bar"
p x[:foo]
p x.to_response
