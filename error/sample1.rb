# encoding: utf-8
# Exceptionでやるケース

require 'json'

class ControllerMock
  attr_reader :params

  class UserError < Exception
  end

  def initialize params={}
    @params = params
  end

  def test_route
    data = {}
    login_id = params[:login_id]
    password = params[:password]
    raise UserError.new('ログインIDねーよ') if login_id.empty?
    raise UserError.new('パスワードねーよ') if password.empty?
    nil.empty?
    data[:status] = 'ok'
    data[:name] = 'hagiwara'
  rescue UserError => e
    data[:status] = 'ng'
    data[:message] = e.message
  ensure
    p data.to_json
  end

  def test_route2
  rescue UserError => e
    data[:status] = 'ng'
    data[:message] = e.message
  ensure
    p data.to_json
  end

end

#controller = ControllerMock.new(login_id: 'hoge')
#controller = ControllerMock.new(login_id: '')
#controller = ControllerMock.new(login_id: 'hoge', password: '')
#controller = ControllerMock.new(login_id: '', password: '')
controller = ControllerMock.new(login_id: 'hagi', password: 'jojo')
controller.test_route
