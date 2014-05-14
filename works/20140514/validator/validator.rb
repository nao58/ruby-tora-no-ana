# encoding: utf-8

require './validators/base'
require './var_types/base'

class Validator

  def self.get key
    require File.join(File.dirname(__FILE__), 'validators', key.to_s)
    class_name = key.to_s.split('_').map {|w| w.capitalize}.join
    const_get(class_name).new
  end

end


params = {
  uid: 'hagiwara',
  pwd: 'hogehoge'
}

#params[:uid] = '1a'
#params[:pwd] = nil
params[:uid] = 'takashi'
params[:name] = '萩原'
params[:age] = 'a3'

validator = Validator.get(:login)
unless validator.valid?(params)
  msgs = validator.error_messages
  p msgs
end


require './var_types/number'
x = Validator::VarType::Number.new(label: 'テスト項目')
p x.valid? "xx"
p x.valid? "33"
p x.valid? "x3"
p x.valid? "3x"
p x.valid? "0"
p x.valid? "0.1"
p x.valid? "-1"
p x.error_messages
