# encoding: utf-8

class Validator::Method

  def self.custom setting, key_name, value
    setting.call key_name, value
  end

  def self.min_length setting, key_name, value
    "#{key_name}は#{setting}文字以上にしてください" unless setting <= value.size
  end

  def self.max_length setting, key_name, value
  end

  def self.regexp setting, key_name, value
  end

  def self.numeric setting, key_name, value
    "#{key_name}には数値を指定してください" unless value =~ /^[0-9]+$/
  end

  def self.min setting, key_name, value
    "#{key_name}は#{setting}以上である必要があります" unless value.to_i >= setting
  end

end
