# encoding: utf-8

class TestClass

  def self.hoge num
    ret = 100 / num
  rescue
    p "error"
  ensure
    p "fin."
    return ret
  end

end

p TestClass.hoge 0
p TestClass.hoge 10
