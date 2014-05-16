# encoding: utf-8

require 'singleton'

class Redis
  include ::Singleton

  def initialize
    @data = {}
  end

  def connect conn
    @conn = conn
    @data[conn] ||= {}
  end

  def exists_key? key
    @data.key? key
  end

  def []= key, val
    @data[@conn][key] = val
  end

  def [] key
    @data[@conn][key]
  end

  def delete key
    @data[@conn].delete(key)
  end

  def each
    @data[@conn].each do |key, val|
      yield key, val
    end
  end

  def dump
    p "Redis: key=#{@conn}: #{@data}"
  end

end
