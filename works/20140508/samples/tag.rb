# encoding: utf-8

class Tag
  attr_accessor :content_proc

  def initialize tag_name, &block
    @tag_name = tag_name
    @attr_list = [:src, :name, :target, :href]
    @content_proc = block_given? ? block : Proc.new{|content| content}
  end

  def print content, attr={}
    attr_str = attr.each_with_object '' do |(key, val), ret|
      ret << %! #{key}="#{val}"! if @attr_list.include?(key)
    end
    content = @content_proc.call(content)
    %!<#{@tag_name}#{attr_str}>#{content}</#{@tag_name}>!
  end

end

=begin
x = Tag.new('a')
x.print 'dummy', {}
x.print 'netprice', src: 'http://www.netprice.co.jp', target: '_blank'
x.print 'google', name: 'google', hoge: 'hogehoge', foo: 'bar'

x.content_proc = Proc.new{|cont| cont*2}
x.print 'google', name: 'google', hoge: 'hogehoge', foo: 'bar'

lists = Tag.new('ul')
lists.content_proc = Proc.new{|lists| lists.map{|list|"<li>#{list}</li>"}.join('')}
lists.print %w(aaa bbb ccc)
lists.print %w(x y z)

links = {aaa: 'http://www.google.com', bbb: 'http://www.netprice.co.jp', ccc: 'http://yahoo.com'}
link_tag = Tag.new('a')
lists.content_proc = Proc.new{|lists|
  lists.map do |list|
    if links.key?(list.to_sym)
      cont = link_tag.print(list, href: links[list.to_sym])
    else
      cont = list
    end
    "<li>#{cont}</li>"
  end.join('')
}
p lists.print %w(aaa bbb ccc)
p lists.print %w(ccc xxx)

=end
lists = Tag.new('ul') do |lists|
  links = {aaa: 'http://www.google.com', bbb: 'http://www.netprice.co.jp', ccc: 'http://yahoo.com'}
  link_tag = Tag.new('a')
  lists.map do |list|
    if links.key?(list.to_sym)
      cont = link_tag.print(list, href: links[list.to_sym])
    else
      cont = list
    end
    "<li>#{cont}</li>"
  end.join('')
end
p lists.print %w(aaa bbb ccc)
p lists.print %w(ccc xxx)
