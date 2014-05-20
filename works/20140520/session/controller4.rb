# encoding: utf-8

# Moduleをinclude（全部）
#
class Controller
  module Session
    def before
      @settings[:session] = 'NormalSession'
    end
    def create_or_update_normal_session
      ret = settings[:session]
      set_cookie('session', ret)
      delete_order_session
      delete_mynetprice_session
    end
    def delete_order_session
    end
    def delete_myneprice_session
    end
  end
end

class ControllerApi
  include Session

  def route path
    create_or_update_normal_session
  end
end

class ControllerGathers
end

class Controller
  include Session
  attr_reader :cookie

  def initialize
    @settings = {}
    @cookie = {}
    @hoge = "hoge"
    before
  end

  def settings
    @settings
  end

  def set_cookie key, val
    @cookie[key] = val
  end

  def route path
    create_or_update_normal_session
  end

end

# framework
c = Controller.new
c.route '/login'
p c.cookie


