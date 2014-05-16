# encoding: utf-8

class Response

  def initialize
    @data = {}
  end

  def set_cookie key, opts
    @data[key] = opts
  end

  def get_cookie key
    @data[key][:value]
  end

  def each_cookie
    @data.each do |key, val|
      yield key, val[:value]
    end
  end

  def dump
    p "Cookie: #{@data}"
  end
  
end
