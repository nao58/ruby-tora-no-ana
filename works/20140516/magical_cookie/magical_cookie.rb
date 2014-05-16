# encoding: utf-8

require './stub/response'
require './stub/redis'

class MagicalCookie < ::Hash

  def initialize response, uid=nil
    require './jar/cookie'
    require './jar/kvs'
    @uid = uid
    if @uid.nil?
      @bin = Jar::Cookie.new(response)
    else
      # authentication etc.
      @bin = Jar::Kvs.new(@uid)
      link response if @bin.exists_uid?
    end
  end

  def login?
    !@uid.nil?
  end

  def []= key, val
    @bin[key] = val
    super
  end

  def [] key
    @bin[key]
    super
  end

  def delete key
    @bin.delete key
    super
  end

  def dump
    p "Magic Cookie: "
    @bin.each do |key, val|
      p "  #{key}: #{val}"
    end
  end
 
  def link response
    cookie = Jar::Cookie.new(response)
    cookie.each do |key, val|
      self[key] = val
    end
  end

end



puts ' not login '.center(50, '#')
response = Response.new
uid = nil   # not logined.
mc = MagicalCookie.new(response, uid)
mc[:foo] = 'bar'
mc[:hoge] = '123'
mc.dump
response.dump
Redis.instance.dump
puts ''


puts ' link '.center(50, '#')
uid = 'hagiwara'   # not logined.
mc = MagicalCookie.new(response, uid)
mc.dump
response.dump
Redis.instance.dump
puts ''



puts ' login '.center(50, '#')
response = Response.new
uid = 'hagiwara'   # not logined.
mc = MagicalCookie.new(response, uid)
mc.dump
response.dump
Redis.instance.dump
puts ''



puts ' login and update '.center(50, '#')
response = Response.new
uid = 'hagiwara'   # not logined.
mc = MagicalCookie.new(response, uid)
mc[:hoge] = '999'
mc[:hogehoge] = 'xyz'
mc.dump
response.dump
Redis.instance.dump
puts ''
