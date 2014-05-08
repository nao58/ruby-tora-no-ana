# encoding: utf-8

class TestClass < Hash

  def initialize
    @self_update = false
  end

  def error msg
    #self[:status] = 'ng'
    self_update :status, 'ng'
  end

  def []= key, val
    raise "boooo!" if key == :status && !@self_update
    super
  end

  private
  def self_update key, val
    @self_update = true
    self[key] = val
    @self_update = false
  end
end

x = TestClass.new
x.error 'mmmmm'
p x
x[:status] = 'ok'
#p x
