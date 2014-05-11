# encoding: utf-8

# 現在時間を返すProc
p "#1:"
time = Proc.new {Time.now}
p time.call

# 引数を3倍にして返すProc
p "#2:"
x = Proc.new {|v| v * 3}
p x.call 3 
p x.call 'var'

# 引数で配列を受け取り、各値を3倍にした配列を返すProc
p "#3:"
y = Proc.new {|ary|
  ary.map{|i| i * 3}
}
y_arr = [1, 2, 3, 4, 5] 
p y.call y_arr

# クラスに対して上記Procを渡し、hogeメソッドの引数に対してProcを呼び出して返すようにする
p "#4:"
class TestClass

  attr_accessor :custom_proc

  def initialize
    @custom_proc = nil
  end

  def hoge var 
    @custom_proc.call var
  end

end

tc = TestClass.new
tc.custom_proc = y 
p tc.hoge [1, 2, 3] 

# 前述のProcを値を5倍にするものに変更する
tc.custom_proc = Proc.new {|ary| 
  ary.map{|i| i * 5}
}
p tc.hoge [1, 2, 3] 

