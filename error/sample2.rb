# encoding: utf-8
# 戻り値をオブジェクト化するケース

require 'json'

class ControllerMock
  attr_reader :params, :rv

  class ResponseValue < ::Hash
    def initialize params
      @params = params
      @error = false
      @error_msg = nil
    end
    def error msg
      unless error?
        @error = true
        @error_msg = msg
      end
    end
    def mandatory_check keys
      keys.each do |key, name|
        if @params[key].empty?
          error "#{name}は必須だべ"
        end
      end
    end
    def error?
      @error
    end
    def to_response
      self[:status] = (@error ? 'ng' : 'ok')
      self[:message] = @error_msg if error?
      if @params[:format] == 'json'
        self.to_json
      else
        self.to_s
      end
    end
  end

  def initialize params={}
    @params = params
    @rv = ResponseValue.new(@params)
  end

  def test_route
    login_id = params[:login_id]
    password = params[:password]
    #rv.error 'ログインIDねーずら' if login_id.empty?
    #rv.error 'パスワードねーよ' if password.empty?
    rv.mandatory_check :login_id => 'ログインID', :password => 'ぱすわ〜ど'
    unless rv.error?
      rv[:name] = 'hagiwara'
    end
    p rv.to_response
  end

end

#controller = ControllerMock.new(login_id: 'hoge')
controller = ControllerMock.new(login_id: 'hoge', password: '')
#controller = ControllerMock.new(login_id: '', password: '')
#controller = ControllerMock.new(login_id: 'hagi', password: 'jojo')
controller.test_route

