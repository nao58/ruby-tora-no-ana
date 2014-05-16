# encoding: utf-8

class MagicalCookie
  module Jar
    class Cookie

      def initialize response
        @response = response
        @default_opts = {
          domain: 'www.netprice.co.jp',
          path: '/',
          lifespan: 86400 * 14
        }
      end

      def []= key, val
        opts = {
          value: val,
          domain: @default_opts[:domain],
          path: @default_opts[:path],
          expires: Time.now + @default_opts[:lifespan]
        }
        @response.set_cookie key, opts
      end

      def [] key
        @response.get_cookie key
      end

      def delete key
        opts = {
          value: nil,
          domain: @default_opts[:domain],
          path: @default_opts[:path],
          expires: Time.new(1970, 1, 1, 0, 0, 0)
        }
        @response.set_cookie key, opts
      end

      def each
        @response.each_cookie do |key, val|
          yield key, val
        end
      end

    end
  end
end
