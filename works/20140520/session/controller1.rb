# encoding: utf-8

# 全部入り（現状）
#
class Controller
  attr_reader :cookie

  def initialize
    @settings = {}
    @cookie = {}
    @settings[:session] = 'NormalSession'
  end

  def settings
    @settings
  end

  def set_cookie key, val
    @cookie[key] = val
  end

  def create_or_update_normal_session
    ret = settings[:session]
    set_cookie('session', ret)
  end

  def route path
    create_or_update_normal_session
  end

end

# framework
c = Controller.new
c.route '/login'
p c.cookie
