# encoding: utf-8

class Tag

  def initialize tag_name
    @tag_name = tag_name
    @attr_list = [:src, :name, :target]
  end

  def print content, attr={}
    #attr_str = attr.map{|k,v| %! #{k}="#{v}"!}.join('')
    #
    attr_str = attr.each_with_object '' do |(key, val), ret|
      ret << %! #{key}="#{val}"! if @attr_list.include?(key)
    end
    p %!<#{@tag_name}#{attr_str}>#{content}</#{@tag_name}>!
  end

end

x = Tag.new('a')
x.print 'dummy', {}
x.print 'netprice', src: 'http://www.netprice.co.jp', target: '_blank'
x.print 'google', name: 'google', hoge: 'hogehoge', foo: 'bar'
