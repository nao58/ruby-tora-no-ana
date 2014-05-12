# encoding: utf-8

class SampleClass
  attr_reader :last_error

  def test1
    {status: false, error: {id: '必須です'}}
  end

  def test2
    [false, {id: '必須です'}]
  end

  def test3
    @last_error = {id: '必須です'}
    false
  end

  def test4
    ret = false
    yield ret, {id: '必須です'} if block_given?
    ret
  end

  def test5
    raise ValidError.new({id:'必須です'})
    true
  end

  class ValidError < Exception
    attr_reader :valid_error
    def initialize valid_error
      @valid_error = valid_error
      super ""
    end
  end

end

x = SampleClass.new


##################################################
# pattern 1
res = x.test1
unless res[:status]
  p res[:error]
end
# ハッシュの記述がめんどくさい
# メソッド名がvalid?みたいな時に、boolじゃない値が返ってくると気持ち悪い


##################################################
# pattern 2
status, error = x.test2
unless status
  p error
end
# メソッド名がvalid?みたいな時に、boolじゃない値が返ってくると気持ち悪い


##################################################
# pattern 3
unless x.test3
  p x.last_error
end

##################################################
# pattern 4
if x.test4
  p "hogehoge"
end
x.test4 do |status, error|
  p error
end

##################################################
# pattern 5
begin
  x.test5
rescue SampleClass::ValidError => e
  p e.valid_error
end
