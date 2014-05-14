# encoding: utf-8

class Validator::Login < Validator::Base

  def setting
    variable :uid, :np_user_id, mandatory: true, label: 'ログインID'
    #variable :pwd, :np_user_password, mandatory: true
    variable :name, :text, label: '氏名'
    var_attr :name, :min_length, 6
    var_attr :name, :max_length, 10

    variable :age, :number, label: '年齢'
    var_attr :age, :custom, Proc.new{|k,v| "未成年の方には売れません" if v.to_i<20}
  end

end
