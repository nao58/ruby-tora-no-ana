# encoding: utf-8

# before filterでインスタンス変数に入れる
class Controller1
  def before
    @login_gate = Login.new
  end
  get '/login' do
    @login_gate.soft_login
  end
end

# methodとして実装する
class Controller2
  def login_gate
    @login_gate ||= Login.new
  end
  get '/login' do
    login_gate.soft_login
  end
end
