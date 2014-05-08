# encoding: utf-8

class TestClass < Hash

  def error msg
    @status = 'ng'
    @err_msg = msg
  end

  def []= key, val
    raise "boooo!" if key == :status
    super
  end

  def [] key
    raise "dont peep this status!" if key == :status
    super
  end

  def status
    @status
  end

  def << val
    val.each{|k,v| self[k]=v}
  end

end

=begin
x = TestClass.new
x.error 'mmmmm'
p x[:status]
x[:hoge] = 'abc'
p x[:hoge]
p 'hehe' if x[:status] == 'ng'
=end

item = {id: 1234, name: 'hogehoge', price: 10000}
x = TestClass.new
x.error 'hogehoge'
x << item
p x
p x.class


