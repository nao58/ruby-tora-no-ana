# encoding: utf-8

# Moduleをinclude
#
class Controller
  module NormalSession
    def create_or_update_normal_session
      ret = settings[:session]
      set_cookie('session', ret)
      delete_order_session if respond_to?(:delete_order_session)
      delete_mynetprice_session
    end
  end

  module OrderSession
    def delete_order_session
    end
  end

  module MyNetpriceSession
    def delete_myneprice_session
    end
  end
end

class ControllerApi
  include NormalSession
  include OrderSession

  def route path
    create_or_update_normal_session
  end
end

class ControllerGathers
  include NormalSession
end

class Controller
  include NormalSession
  include OrderSession
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

  def route path
    create_or_update_normal_session
  end

end

# framework
c = Controller.new
c.route '/login'
p c.cookie

