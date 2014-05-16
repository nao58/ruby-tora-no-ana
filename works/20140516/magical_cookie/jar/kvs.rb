# encoding: utf-8

class MagicalCookie
  module Jar
    class Kvs

      def initialize uid
        @uid = uid
        # connect to redis server
        @redis = Redis.instance
        @redis.connect uid
      end

      def exists_uid?
        @redis.exists_key?(@uid)
      end

      def []= key, val
        # write to redis
        @redis[key] = val
      end

      def [] key
        # get by redis
        @redis[key]
      end

      def delete key
        # delete from redis
        @redis.delete key
      end

      def each
        @redis.each do |key, val|
          yield key, val
        end
      end

    end
  end
end
