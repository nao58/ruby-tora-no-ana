# encoding: utf-8

# Sessionを扱うObject
#
class Controller
  class NormalSession
    def initialize settings, request, response, order_session, mynetprice_session
      @settings = settings
      @request = request
      @response = response
      @order_session = order_session
      @mynetprice_session = mynetprice_session
    end
    def create_or_update
      ret = @settings[:session]
      @response.set_cookie('session', ret)
      @order_session.delete
      @mynetprice_session.delete
    end
  end

  class OrderSession
    def delete
    end
  end

  class MyNetpriceSession
    def delete
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


