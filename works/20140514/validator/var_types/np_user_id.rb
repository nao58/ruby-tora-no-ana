# encoding: utf-8

class Validator::VarType
  class NpUserId < Base

    def setting
      name '会員ID'
      attribute :min_length, 6
      attribute :max_length, 30
      attribute :regexp, /^[a-zA-Z][a-zA-Z0-9\._]+$/
      attribute :custom, Proc.new{|key_name, value|
        "#{key_name}に'hagiwara'は指定できません" if value=='hagiwara'
      }
      attribute :custom, Proc.new{|key_name, value|
        "#{key_name}に'takashi'は指定できません" if value=='takashi'
      }
    end

  end
end
