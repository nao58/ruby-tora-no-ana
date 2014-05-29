# encoding: utf-8

class Hash

  def deep_symbolize_keys
    self.each_with_object({}){|(k,v),memo| memo[k.to_s.to_sym]=(v.is_a?(Hash) ? v.deep_symbolize_keys : v)}
  end

  def symbolize_keys
    self.each_with_object({}){|(k,v),memo| memo[k.to_s.to_sym]=v}
  end

end

h = {'a' => {'b' => 123, 'c' => {'x' => 'hoge'}, 123 => 'a'}, 'x' => 123, :foo => 'bar'}

p h
p h.deep_symbolize_keys
p h.symbolize_keys
