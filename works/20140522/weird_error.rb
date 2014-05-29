# encoding: utf-8

class Sinatra
  class Base
    def initialize
      p "sinatra base initialized!"
      @hoge = "hogehoge"
    end
    def hoge
      @hoge.size
    end
  end
end

class WebServer < Sinatra::Base
  def initialize
    p "web server initialized!"
    super
  end
end



x = WebServer.new
p x.hoge
