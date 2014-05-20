# encoding: utf-8

module MainServer
  class Cookies

    def initialize request, response, site
      @request = request
      @response = response
      @site = site
      @cookies = request.cookies.dup
      # ToDo: config/application.ymlから持ってくる？
      @default_lifetime = 3600*24*7
      @default_cookie_opts = {
        domain: 'www.netprice.co.jp',
        path: '/'
      }
      # ToDo: config/application.ymlから持ってくる？
      @key_lists = {
        member_id: {cookie_key: 'MemberId', lifetime: 3600},
        favorite: {cookie_key: 'sg_cp_favorite_goods_ids', cp_sep: true}
      }
      # ToDo: cookie_keyの重複チェック？
    end

    def method_missing method_name, *args
      method_name = method_name.to_s
      if method_name.end_with?('=')
        key = method_name.delete('=')
        raise "Cannot specify the undefined key '#{key}." if @key_lists.key?(key)
        __set_cookie key, args.first
      else
        key = method_name
        raise "Cannot specify the undefined key '#{key}." if @key_lists.key?(key)
        __get_cookie key
      end
    end

    def favorite
      __get_cookie(:favorite).split(':')
    end

    def favorite= value
      __set_cookie :favorite, value.join(':')
    end

    private
    def __cookie_key key
      #ToDo: cpの時、suffixを付ける処理
      @key_lists[key.to_sym][:cookie_key]
    end

    def __get_cookie key
      cookie_key = __cookie_key(key)
      @cookies[cookie_key]
    end

    def __set_cookie key, val, opts={}
      # ToDo: もう少しかっこよく
      cookie_key = __cookie_key(key)
      info = @key_lists[key.to_sym]
      key_opts = {}
      key_opts[:domain] = info[:domain] if info.key?(:domain)
      key_opts[:path] = info[:path] if info.key?(:path)
      key_opts[:expires] = Time.now + (info.key?(:lifetime) ? info[:lifetime] : @default_lifetime)
      cookie_opts = @default_cookie_opts.merge(key_opts).merge(opts)
      if val.nil?
        cookie_opts[:value] = 'deleted'
        cookie_opts[:expires] = Time.new(1900,1,1,0,0,0,0,0)
        @cookies.delete cookie_key
        @response.set_cookie cookie_key, cookie_opts
      else
        cookie_opts[:value] = val
        @cookies[cookie_key] = val
        @response.set_cookie cookie_key, cookie_opts
      end
    end

    
  end
end

class Request
  attr_reader :cookies
  def initialize
    @cookies = {'MemberId' => 'hagiwara'}
    @cookies['sg_cp_favorite_goods_ids'] = '123:456:999'
  end
end

class Response
  def initialize
    @cookies = {}
  end
  def set_cookie key, options
    @cookies[key] = options
  end
end

request = Request.new
response = Response.new
site = 'Site'
cookies = MainServer::Cookies.new(request, response, site)
p cookies.member_id
cookies.member_id = 'takashi'
p cookies.member_id

fav = cookies.favorite
fav << 300
fav << 222
cookies.favorite = fav
p cookies.favorite
p request
p response

cookies.member_id = nil
p cookies.member_id
p request
p response
